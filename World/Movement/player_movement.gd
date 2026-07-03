@tool
extends MovementComponent;
class_name PlayerMovement;
## Movement node for player control.
##
## player node.


## Speed in pix/sec.
@export var _speed: float = 600.0;


func _physics_process( delta: float ) -> void:
	
	var movement: Vector2 = InputNames.get_move_dir() * _speed * delta;
	_movable_node.position += movement;
	
	const SCREEN_LIMIT := Vector2( Consts.SCREEN_SIZE );
	_movable_node.position = _movable_node.position.clamp( Vector2.ZERO, SCREEN_LIMIT );
