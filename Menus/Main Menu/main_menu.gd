extends Control


@onready var _play_button: Button = %PlayButton
@onready var _settings_button: Button = %SettingsButton
@onready var _desktop_button: Button = %DesktopButton


func _ready() -> void:
	
	_play_button.grab_focus.call_deferred();
