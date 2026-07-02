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

#region Screen Fade

## Emitted when the screen fader covers/uncovers the screen.[br]
## [br]
## is_paused: Is true if the screen is hidden.
signal screen_faded( is_covered: bool );
## Emitted when the screen fader covers/uncovers the screen.[br]
## [br]
## is_paused: Is true if the screen is hidden.
func emit_screen_faded( is_covered: bool ) -> void:
	screen_faded.emit( is_covered );

#endregion Screen Fade

#region Rooms

signal room_changed();
func emit_room_changed() -> void:
	room_changed.emit();

signal room_change_requested( room_path: String );
func request_room_change( room_path: String ) -> void:
	room_change_requested.emit( room_path );

#endregion Rooms

#region Menus

signal menu_requested( menu: Consts.Menu );
func request_menu( menu: Consts.Menu ) -> void:
	menu_requested.emit( menu );

#endregion Menus

#region Settings

## Emitted when the game needs to update in acordance to the settings.
signal settings_changed();
## Tell the game to configure itself to the settings.
func emit_settings_changed() -> void:
	settings_changed.emit();

#endregion Settings
