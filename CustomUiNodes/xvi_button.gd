@tool
extends Button;
class_name XVIButton;


func _init() -> void:
	
	if ( Engine.is_editor_hint() ):
		return;
	
	mouse_entered.connect( _on_mouse_enter, CONNECT_DEFERRED );
	mouse_exited.connect( _on_mouse_left, CONNECT_DEFERRED );
	button_down.connect( _on_button_down, CONNECT_DEFERRED );
	button_up.connect( _on_button_up, CONNECT_DEFERRED );
	focus_exited.connect( _on_focus_left, CONNECT_DEFERRED );
	focus_entered.connect( _on_focus_entered, CONNECT_DEFERRED );


func _on_mouse_enter() -> void:
	grab_focus();

func _on_mouse_left() -> void:
	pass

func _on_button_down() -> void:
	pass

func _on_button_up() -> void:
	pass

func _on_focus_left() -> void:
	pass

func _on_focus_entered() -> void:
	pass
