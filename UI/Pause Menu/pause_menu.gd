extends Control


@onready var resume_button: FFButton = %ResumeButton


func _ready() -> void:
	
	if ( Engine.is_editor_hint() ):
		return;
	
	Radio.pause_changed.connect( _on_radio_game_paused );
	
	hide();
	XVIControlAnimation.close_window( self );


func _on_radio_game_paused( is_paused: bool ) -> void:
	
	if ( is_paused ):
		
		resume_button.grab_focus.call_deferred();
		XVIControlAnimation.open_window( self );
	else:
		
		XVIControlAnimation.close_window( self );


func _on_resume_button_pressed() -> void:
	WindowControls.toggle_pause();
