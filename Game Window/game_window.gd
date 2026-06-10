@tool
extends Control


const SCREEN_SIZE := Vector2i(
	480,
	720
);

const AUTO_SCALE := true;


@onready var _bg_root: Control = %BackgroundRoot;
@onready var _subviewport_container: SubViewportContainer = %SubViewportContainer;
@onready var _subviewport: SubViewport = %SubViewport;


func _ready() -> void:
	
	_subviewport_container.custom_minimum_size = SCREEN_SIZE;
	_subviewport.size_2d_override = SCREEN_SIZE;
	
	if ( Engine.is_editor_hint() ):
		return;
	
	get_window().size_changed.connect( _on_window_size_changed );


func _on_window_size_changed() -> void:
	
	var new_scale := SCREEN_SIZE;
	var scale_factor := 1;
	var window := get_window();
	while true:
		
		scale_factor += 1;
		var next_scale := SCREEN_SIZE * scale_factor;
		if ( next_scale.x > window.size.x or next_scale.y > window.size.y ):
			break
		else:
			new_scale = next_scale;
	
	_subviewport_container.custom_minimum_size = new_scale;
