#@tool
extends Node2D;
class_name TestAsteroid;


const _SPEED = 200;


func _ready() -> void:
	
	if ( Engine.is_editor_hint() ):
		
		XVIFuncs.disable_node_processes( self );
		return;
	
	global_position.y = Consts.SCREEN_SIZE.y;
	global_position.x = Consts.SCREEN_SIZE.x * randf();

func _physics_process( delta: float ) -> void:
	
	if ( position.y < 0.0 ):
		queue_free();
		return;
	
	var move_dist: float = _SPEED * delta;
	position.y -= move_dist;
