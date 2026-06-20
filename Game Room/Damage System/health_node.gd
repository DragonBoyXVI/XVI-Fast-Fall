@tool
extends Node2D;
class_name HealthNode;
## Component that tracks health, provides info about the health,
## and draws it as a bar on the screen if visible.
##
## ditto


const _DEFAULT_GRADIENT: Gradient = preload( "uid://b7n273xmdugsa" );


## Emitted when the current health changes.
signal health_changed( current_hp: int, max_hp: int );
func emit_health_changed() -> void:
	health_changed.emit( _current_health, _max_health );
## Emitted when health reaches 0.
signal died();


@export_group( "Health" )
## Used only for drawing health states in the editor
@export_custom( PROPERTY_HINT_RANGE, "0.0,1.0,0.01", PROPERTY_USAGE_EDITOR ) var _draw_perc := 0.5:
	set( new ):
		_current_health = roundi( _max_health * new );
		_draw_perc = new;
## Base unmodified health for this instance.
@export var _max_health: int = 5:
	set( new ):
		_max_health = maxi( 1, new );
		emit_health_changed()
		queue_redraw();
## If greater than 0, _max_health will be randomized using randfn.
## This is the deviation, and _max_health is the standard.
@export var _health_deviation := 0.0:
	set( new ):
		_health_deviation = absf( new );

@export_group( "Drawing" )
## Health bar displacement.
@export var _offset := Vector2( 0.0, 32.0 ):
	set( new ):
		_offset = new;
		queue_redraw();
## How tall the health bar is.
@export var _height: float = 16.0:
	set( new ):
		_height = new;
		queue_redraw();
## How wide the health bar is.
@export var _width: float = 64.0:
	set( new ):
		_width = new;
		queue_redraw();


var _current_health: int:
	set( new ):
		_current_health = new;
		emit_health_changed();
		
		if ( _current_health <= 0 ):
			died.emit();
		
		queue_redraw();


func _ready() -> void:
	
	if ( Engine.is_editor_hint() ):
		return;
	
	if ( _health_deviation > 0.0 ):
		_max_health = roundi( randfn( _max_health, _health_deviation ) );
	
	_current_health = _max_health;

func _validate_property( property: Dictionary ) -> void:
	FFFuncs.disable_prop_2ds( property );

func _draw() -> void:
	
	var rect := Rect2(
		-( _width * 0.5 ) + _offset.x, -( _height * 0.5 ) + _offset.y,
		_width, _height
	);
	
	draw_rect( rect, Color.FIREBRICK );
	
	var percent := get_as_percent();
	rect.size.x *= percent;
	var color := _DEFAULT_GRADIENT.sample( percent );
	draw_rect( rect, color );


func take_damage( dmg: Damage ) -> void:
	_current_health -= dmg.amount;

func take_heal( heal: Heal ) -> void:
	_current_health = mini( _current_health + heal.amount, _max_health );

## Returns health as a float between 0 - 1.
func get_as_percent() -> float:
	var percent := _current_health / float( _max_health );
	return clampf( percent, 0.0, 1.0 );

## Return health as a string.
func get_as_string() -> String:
	const FORMAT := "%s/%s";
	return FORMAT % [ _current_health, _max_health ];
