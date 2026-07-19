@tool
extends Node2D;
class_name HealthNode2D;
## Tracks and provides hp info, and draws an hp bar on the screen.
##
## ditto


const _HP_GRADIENT = preload("uid://c2pxmhq38uul0");
const _CRACK_MAT = preload("uid://cfeucd3fh3lww");


signal died();
signal hp_changed( hp_current: int, hp_max: int, hp_percent: float );
func emit_hp_change() -> void:
	hp_changed.emit( _current_hp, _max_hp, hp_as_percent() );


@warning_ignore( "unused_private_class_variable" )
@export_custom( PROPERTY_HINT_RANGE, "0.0,1.0,0.01", PROPERTY_USAGE_EDITOR ) var _editor_percent: float = 0.5:
	set( new ):
		_editor_percent = clampf( new, 0.0, 1.0 );
		_current_hp = roundi( _max_hp * new );
		queue_redraw();
	get:
		if ( not is_node_ready() ):
			return 0.5;
		return hp_as_percent();

@export_group( "Health", "_hp_" )
## The base hp of this node.
@export var _hp_base: int = 5:
	set( new ):
		_hp_base = maxi( 1, new );
		queue_redraw();
		
		if ( Engine.is_editor_hint() ):
			_max_hp = new;

@export_group( "Bar", "_bar_" )
## If true, this node draws an hp bar.
@export_custom( PROPERTY_HINT_GROUP_ENABLE, "" ) var _bar_enabled: bool = false:
	set( new ):
		_bar_enabled = new;
		queue_redraw();
## How offset the center of the bar is from its node.
@export var _bar_offset: Vector2 = Vector2( 0.0, 32.0 ):
	set( new ):
		_bar_offset = new;
		queue_redraw();
## The dimensions of the bar. X is width, y is height.
@export var _bar_dimensions: Vector2 = Vector2( 128.0, 16.0 ):
	set( new ):
		_bar_dimensions = new.abs();
		queue_redraw();
@export_subgroup( "Background", "_bar_bg_" )
## Color of the bar background
@export_color_no_alpha var _bar_bg_color: Color = Color.BLACK:
	set( new ):
		_bar_bg_color = new;
		queue_redraw();
## Size of the border around the bar.
@export var _bar_bg_size: int = 3:
	set( new ):
		_bar_bg_size = maxi( 0, new );
		queue_redraw();


var _max_hp: int = 0;
func get_max_hp() -> int: return _max_hp;
var _current_hp: int = 0;
func get_current_hp() -> int: return _current_hp;
var _is_dead := false;
func is_dead() -> bool: return _is_dead;


func _ready() -> void:
	
	_max_hp = _hp_base;
	_current_hp = _max_hp;
	
	if ( Engine.is_editor_hint() ):
		return;
	pass;

func _draw() -> void:
	if ( not _bar_enabled ): return;
	
	
	var bar_pos: Vector2 = _bar_offset - ( _bar_dimensions * 0.5 );
	var bar_size: Vector2 = _bar_dimensions;
	var bar_rect: Rect2 = Rect2( bar_pos, bar_size );
	
	var _bornana := Vector2( _bar_bg_size, _bar_bg_size );
	var border_rect: Rect2 = Rect2(
		bar_rect.position - _bornana,
		bar_rect.size + ( _bornana * 2)
	);
	
	# background
	draw_rect( border_rect, _bar_bg_color );
	
	# health
	var percent: float = hp_as_percent();
	var hp_rect: Rect2 = Rect2(
		bar_rect.position,
		bar_size * Vector2( percent, 1.0 )
	);
	var hp_color: Color = _HP_GRADIENT.sample( percent );
	draw_rect( hp_rect, hp_color );


func damage( inst: DamageInst ) -> void:
	
	_current_hp -= inst.amount;
	emit_hp_change();
	
	if ( _current_hp <= 0 ):
		died.emit();
	
	queue_redraw();

func heal( amount: int ) -> void:
	_current_hp = mini( _current_hp + amount, _max_hp );
	queue_redraw();


func hp_as_percent() -> float:
	return clampf( float( _current_hp ) / _max_hp, 0.0, 1.0 );
