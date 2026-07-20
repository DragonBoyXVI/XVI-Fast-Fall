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



## Emitted when the start game button is pressed on the main menu
signal game_start_pressed();
## Emitted when the start game button is pressed on the main menu
func emit_game_start_pressed() -> void:
	game_start_pressed.emit();

#endregion Game State

#region Screen Fade

## Emitted when the screen fader has shown the screen.
signal screen_shown();
func emit_screen_shown() -> void:
	screen_shown.emit();
## Emitted when the screen fader has hidden the screen.
signal screen_hidden();
func emit_screen_hidden() -> void:
	screen_hidden.emit();
## Emitted when we want the screen shown.
signal screen_show_requested();
## Call to start showing the screen.
func request_screen_show() -> void:
	screen_show_requested.emit();
## Emitted when we want the screen hidden.
signal screen_hide_requested();
## Call to start hiding the screen.
func request_screen_hide() -> void:
	screen_hide_requested.emit();

#endregion Screen Fade

#region Settings

## Emitted when the game needs to update in acordance to the settings.
signal settings_changed();
## Tell the game to configure itself to the settings.
func emit_settings_changed() -> void:
	settings_changed.emit();

#endregion Settings

#region Damage System

#signal damage_object( hitbox: Hitbox, damage: Object );
#signal damage_details( details: Object );

#endregion Damage System
