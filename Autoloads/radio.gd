extends Node


#region Game State

## Emitted when the game is paused/unpaused.[br]
## [br]
## is_paused: Is true if the game is paused.
signal pause_changed( is_paused: bool );
## Emitted when the game is paused/unpaused.[br]
## [br]
## is_paused: Is true if the game is paused.
func emit_pause_changed( is_paused: bool ) -> void:
	pause_changed.emit( is_paused );

#endregion Game State

#region Settings

## Emitted when the game needs to update in acordance to the settings.
signal settings_changed();
## Tell the game to configure itself to the settings.
func emit_settings_changed() -> void:
	settings_changed.emit();

#endregion Settings
