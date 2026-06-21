extends Node;
## Manages some standard controls for the game window (eg pausing, fullscreen).


func _init() -> void:
	
	process_mode = Node.PROCESS_MODE_ALWAYS;

func _input( event: InputEvent ) -> void:
	
	if ( event.is_action_pressed( InputNames.PAUSE ) ):
		
		toggle_pause();
		
		get_window().set_input_as_handled();
		return;
	
	if ( event is InputEventKey ):
		if ( event.keycode == KEY_F11 and event.pressed ):
			
			_toggle_fullscreen();
			
			get_window().set_input_as_handled();
			return;


func toggle_pause() -> void:
	
	var tree := get_tree();
	tree.paused = !tree.paused;
	Radio.emit_pause_changed( tree.paused );

func set_pause( paused: bool ) -> void:
	
	var tree := get_tree();
	if ( paused != tree.paused ):
		tree.paused = paused;
		Radio.emit_pause_changed( paused );


func _toggle_fullscreen() -> void:
	
	if ( Settings.fullscreen_mode == Settings.FullscreenMode.WINDOWED ):
		Settings.fullscreen_mode = Settings.FullscreenMode.FULLSCREEN;
	else:
		Settings.fullscreen_mode = Settings.FullscreenMode.WINDOWED;
	
	Radio.emit_settings_changed();
