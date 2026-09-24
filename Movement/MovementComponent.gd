@tool
extends Node;
class_name MovementComponent;


## The node this moves.
@export var target_node: Node2D:
	set( new ):
		target_node = new;
		update_configuration_warnings();

## The max speed this can hit in pix/sec.
@export var top_speed: float = 1200.0:
	set( new ):
		top_speed = absf( new );
## Acceleration in pix/sec.
@export var acceleration: float = 3000.0:
	set( new ):
		acceleration = absf( new );
## Deceleration in pix/sec.
@export var decerleration: float = 4000.0:
	set( new ):
		decerleration = absf( new );


## Direction this should accelerate towards.
var velocity_dir: Vector2 = Vector2.ZERO:
	set( new ):
		if ( new.length_squared() > 1.0 ):
			velocity_dir = new.normalized();
		else:
			velocity_dir = new;

## Velocity applied to target node every frame.
var _current_velocity: Vector2 = Vector2.ZERO;


func _get_configuration_warnings() -> PackedStringArray:
	var warnings := PackedStringArray();
	
	if ( target_node == null ):
		warnings.append( "No target node set!" );
	elif ( target_node != get_parent() ):
		warnings.append( "This should ideally be a direct child of its parent." );
	
	return warnings;

func _ready() -> void:
	
	if ( Engine.is_editor_hint() ):
		
		XVIFuncs.set_node_processes( self, false );
		return;

func _physics_process( delta: float ) -> void:
	
	var target_velocity: Vector2 = velocity_dir * top_speed;
	
	var velocity_delta: float = delta;
	const TURN_LIMIT: float = PI * 0.5;
	if ( absf( target_velocity.angle_to( _current_velocity ) ) > TURN_LIMIT ):
		velocity_delta *= acceleration;
	else:
		velocity_delta *= decerleration;
	
	_current_velocity = _current_velocity.move_toward( target_velocity, velocity_delta );
	target_node.translate( _current_velocity );


func hard_stop() -> void:
	
	_current_velocity = Vector2.ZERO;
	velocity_dir = Vector2.ZERO;
