extends Node2D

@onready var _menu_ui: MarginContainer = %MenuUI

@onready var _play_button: Button = %PlayButton
@onready var _settings_button: Button = %SettingsButton
@onready var _quit_button: Button = %QuitButton


func _ready() -> void:
	
	_play_button.grab_focus.call_deferred();
	_play_button.pressed.connect( _on_play_button_pressed );



func _on_play_button_pressed() -> void:
	
	XVIControlAnimation.close_window( _menu_ui );
	Radio.emit_game_start_pressed();
