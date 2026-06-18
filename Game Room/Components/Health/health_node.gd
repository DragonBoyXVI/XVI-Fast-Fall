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
## Base unmodified health for this instance.
@export var _max_health: int = 5:
	set( new ):
		_max_health = maxi( 1, new );
		emit_health_changed()
		queue_redraw();

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


## Deal damage to this node.
func take_damage( dmg: Damage ) -> void:
	_current_health -= dmg.amount;

## Returns health as a float between 0 - 1.
func get_as_percent() -> float:
	var percent := _current_health / float( _max_health );
	return clampf( percent, 0.0, 1.0 );

## Return health as a string.
func get_as_string() -> String:
	const FORMAT := "%s/%s";
	return FORMAT % [ _current_health, _max_health ];
