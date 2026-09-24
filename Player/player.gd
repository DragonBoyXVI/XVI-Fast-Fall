extends Node2D;
class_name ObjPlayer;


const STATE_FREE := &"PlayerStateFree";


func _physics_process( _delta: float ) -> void:
	position = position.clamp( Vector2.ZERO, Consts.SCREEN_SIZE );
