@tool
extends Node2D;
class_name HealthNode;


const HP_GRADIENT: Gradient = preload("uid://cg6n60eoykaii");


## Emitted when this node runs out of health.
signal died();
## Emitted when hp info changes
signal health_changed();


## The base max health, before any scaling.
@export var _health_max_base: int = 5:
	set( new ):
		_health_max_base = maxi( 1, new );

@export_group( "Health Bar", "_bar" )
## If true, a health bar is drawn.
@export_custom( PROPERTY_HINT_GROUP_ENABLE, "" ) var _bar_enabled: bool = false:
	set( new ):
		_bar_enabled = new;
		queue_redraw();
## The offset from this node to the center of the health bar.
@export var _bar_offset: Vector2 = Vector2( 0.0, 32.0 ):
	set( new ):
		_bar_offset = new;
		queue_redraw();
## The size of the health bar, in length and width.
@export var _bar_size: Vector2 = Vector2( 48.0, 16.0 ):
	set( new ):
		_bar_size = new.abs();
		queue_redraw();
## The border drawn around the fill in pixels.
@export var _bar_outline_size: int = 3:
	set( new ):
		_bar_outline_size = maxi( 0, new );
		queue_redraw();
## Color of the bar border/back.
@export_color_no_alpha var _bar_color: Color = Color.BLACK:
	set( new ):
		_bar_color = new;
		queue_redraw();
## Used purely in the editor to change how much the bar is visually filled.
@export_custom( PROPERTY_HINT_RANGE, "0.0,1.0,0.01", PROPERTY_USAGE_EDITOR ) var _bar_fill_percent: float = 1.0:
	set( new ):
		_bar_fill_percent = new;
		queue_redraw();


var _max_hp: int;
func get_health_max() -> int: return _max_hp;
var _current_hp: int;
func get_health_current() -> int: return _current_hp;
var _is_dead: bool = false;
func is_dead() -> bool: return _is_dead;


func _ready() -> void:
	
	if ( Engine.is_editor_hint() ):
		return;
	
	_max_hp = _health_max_base;
	_current_hp = _max_hp;

func _draw() -> void:
	if ( not _bar_enabled ): return;
	
	var half_size: Vector2 = _bar_size * 0.5;
	var border_vec: Vector2 = Vector2.ONE * _bar_outline_size;
	var bar_rect: Rect2 = Rect2(
		_bar_offset - half_size - border_vec,
		_bar_size + ( border_vec * 2 )
	);
	
	var percent: float = _bar_fill_percent;
	if ( not Engine.is_editor_hint() ):
		percent = get_health_percent();
	var fill_rect: Rect2 = Rect2(
		_bar_offset - half_size,
		_bar_size * Vector2( percent, 1.0 )
	);
	
	draw_rect( bar_rect, _bar_color );
	draw_rect( fill_rect, HP_GRADIENT.sample( percent ) );


func damage( amount: int ) -> void:
	
	_current_hp -= amount;
	queue_redraw();
	health_changed.emit();
	if ( _current_hp <= 0 and not _is_dead ):
		_is_dead = true;
		died.emit();

func heal( amount: int ) -> void:
	damage( -amount );

## Returns a float between 0.0 and 1.0.
## This is the percentage of health remaining.
func get_health_percent() -> float:
	var percent: float = _max_hp / float( _current_hp );
	return clampf( percent, 0.0, 1.0 );
