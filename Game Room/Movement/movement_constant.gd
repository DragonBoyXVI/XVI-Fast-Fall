@tool
extends MovementNode;
class_name MovementConstant;
## Moves the target node at a constant speed.
##
## doobie


@export var velocity := Vector2();


func _physics_process( delta: float ) -> void:
	_actor.translate( velocity * delta );
