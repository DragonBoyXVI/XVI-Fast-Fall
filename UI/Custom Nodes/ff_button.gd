@tool
extends Button;
class_name FFButton;



const _DOWN: AudioStream = preload("uid://baf0bk80ooe1k");
const _UP: AudioStream = preload("uid://baf0bk80ooe1k");


func _init() -> void:
	
	if ( Engine.is_editor_hint() ):
		return;
	
	focus_entered.connect( GlobalSfx.focused );
	mouse_entered.connect( grab_focus, CONNECT_DEFERRED );
	
	button_down.connect( GlobalSfx.button_down );
	button_up.connect( GlobalSfx.button_up );
