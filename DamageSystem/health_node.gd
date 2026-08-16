@tool
extends Node2D;
class_name HealthNode;
## Keeps track of an hp value, and optionally draws a healthbar to
## the screen.
##
## hlpth


const _HP_GRADIENT: Gradient = preload( "res://DamageSystem/health_gradient.tres" );


## Emitted whenever the health values change.
signal health_changed( current_health: int, max_health: int );
## Emitted when this health node dies.
## Dead health nodes can no longer be interacted with.
signal died();


## If true, this hp node wont take fatal damage unless its at 1 hp.
@export var _use_guts: bool = false;
## The base amount of hp this node wil have before scaling.
@export var _base_health: int = 5:
	set( new ):
		_base_health = maxi( 1, new );

@export_group( "Health Bar", "_health_bar" )
## If enabled, a health bar is drawn to the screen.
@export_custom( PROPERTY_HINT_GROUP_ENABLE, "" ) var _health_bar_is_shown: bool = true:
	set( new ):
		_health_bar_is_shown = new;
		queue_redraw();
## Editor only property that lets you choose the fill of the bar.
@export_custom( PROPERTY_HINT_RANGE, "0.0,1.0,0.01", PROPERTY_USAGE_EDITOR ) var _health_bar_fill: float = 0.5:
	set( new ):
		_health_bar_fill = new;
		queue_redraw();
## How offset the center of the health bar is from this node
@export var _health_bar_offset: Vector2 = Vector2( 0.0, 32.0 ):
	set( new ):
		_health_bar_offset = new;
		queue_redraw();
## Size of the health bar, as length and width
@export var _heatlh_bar_size: Vector2 = Vector2( 128.0, 16.0 ):
	set( new ):
		_heatlh_bar_size = new.maxf( 8.0 );
		queue_redraw();
## How many pixels of padding the bar border has
@export var _health_bar_border: int = 3:
	set( new ):
		_health_bar_border = maxi( 1, new );
		queue_redraw();


var _current_hp: int = 0;
var _max_hp: int = 0;

var _is_dead: bool = false;


func _ready() -> void:

	if ( Engine.is_editor_hint() ):
		return;

	_max_hp = _base_health;
	_current_hp = _max_hp;

func _draw() -> void:
	if ( not _health_bar_is_shown ):
		return;

	var half_bar_size: Vector2 = _heatlh_bar_size * 0.5;
	var base_rect: Rect2 = Rect2(
		position - half_bar_size + _health_bar_offset,
		_heatlh_bar_size
	);

	# back/border
	var border_vec: Vector2 = ( _health_bar_border * Vector2.ONE );
	var back_rect: Rect2 = Rect2(
		base_rect.position - border_vec,
		base_rect.size + ( border_vec * 2 )
	);

	draw_rect( back_rect, Color.BLACK );

	# health
	var health_percent: float = _health_bar_fill
	if ( not Engine.is_editor_hint() ):
		health_percent = get_health_percent();
	var health_rect: Rect2 = Rect2(
		base_rect.position,
		base_rect.size * Vector2( health_percent, 1.0 )
	);

	var hp_color: Color = _HP_GRADIENT.sample( health_percent );
	draw_rect( health_rect, hp_color );


func get_current_health() -> int:
	return _current_hp;

func get_maximum_health() -> int:
	return _max_hp;

func get_health_percent() -> float:
	var percent: float = _current_hp / float( _max_hp );
	return clampf( percent, 0.0, 1.0 );


func take_damage( damage: DamageInst ) -> void:
	if ( _is_dead ):
		return;

	if ( _use_guts and _current_hp > 1 ):
		_current_hp = maxi( _current_hp - damage.amount, 1 );
	else:
		_current_hp -= damage.amount;
	health_changed.emit( _current_hp, _max_hp );

	if ( _current_hp <= 0 ):
		_is_dead = true;
		died.emit();

	queue_redraw();

func take_heal( amount: int ) -> void:

	_current_hp = mini( _current_hp + amount, _max_hp );
	health_changed.emit( _current_hp, _max_hp );

	queue_redraw();
