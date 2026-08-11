@tool
extends Bullet;


var _area_rid: RID;


func initialize() -> void:
	pass

func is_drawable() -> bool:
	return false;

func draw( draw_node: Node2D ) -> void:
	pass

func is_physics_processable() -> bool:
	return false;

func physics_process( delta: float, world: World2D ) -> void:
	pass
