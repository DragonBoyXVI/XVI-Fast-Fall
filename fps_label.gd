extends Label;
class_name FpsLabel;


const _TEXT := "FPS: %s";


@export var on_physics: bool = false;


func _process( _delta: float ) -> void:
	if !on_physics:
		text = _TEXT % Engine.get_frames_per_second();

func _physics_process( _delta: float ) -> void:
	if on_physics:
		text = _TEXT % Engine.get_frames_per_second();
