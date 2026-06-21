@tool
extends Control


@warning_ignore( "unused_private_class_variable" )
@onready var _bg_root: Control = %BackgroundRoot;
@onready var _subviewport_container: SubViewportContainer = %SubViewportContainer;
@onready var _subviewport: SubViewport = %SubViewport;


func _ready() -> void:
	
	_subviewport_container.custom_minimum_size = Consts.SCREEN_SIZE;
	_subviewport.size_2d_override = Consts.SCREEN_SIZE;
	
	if ( Engine.is_editor_hint() ):
		return;
	
	Radio.settings_changed.connect( _resize_game_window, CONNECT_DEFERRED );
	_resize_game_window();
	
	get_window().size_changed.connect( _on_window_size_changed );


func _resize_game_window() -> void:
	
	if ( Settings.force_int_scale > 0 ):
		
		_subviewport_container.custom_minimum_size = Consts.SCREEN_SIZE * Settings.force_int_scale;
		return;
	
	var new_scale := Consts.SCREEN_SIZE;
	
	if ( Settings.integer_scaling_enabled ):
		
		var scale_factor := 1;
		var window := get_window();
		while true:
			
			scale_factor += 1;
			var next_scale := Consts.SCREEN_SIZE * scale_factor;
			if ( next_scale.x > window.size.x or next_scale.y > window.size.y ):
				break
			else:
				new_scale = next_scale;
	else:
		
		var window := get_window();
		var aspect_from_y := Consts.SCREEN_SIZE.y / float( Consts.SCREEN_SIZE.x );
		var window_side_from_y := floori( window.size.x * aspect_from_y );
		
		if ( window.size.x > window.size.y or window_side_from_y > window.size.y ):
			new_scale = Vector2i(
				floori( window.size.y * Consts.SCREEN_SIZE.aspect() ),
				window.size.y
			);
		else:
			new_scale = Vector2i(
				window.size.x,
				window_side_from_y
			);
		
		pass
	
	_subviewport_container.custom_minimum_size = new_scale;


func _on_settings_changed() -> void:
	
	_resize_game_window();

func _on_window_size_changed() -> void:
	
	_resize_game_window();
