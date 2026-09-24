@tool
extends PlayerState;
class_name PlayerStateFree;


@export var _movement: MovementComponent;


func _physics_process( _delta: float ) -> void:
	
	var input_dir: Vector2 = InputNames.Move.get_dir();
	_movement.velocity_dir = input_dir;
