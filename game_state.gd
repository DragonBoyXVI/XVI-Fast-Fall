@abstract
@tool
extends Object;
class_name GameState;
## Tracks game wide state info
##
## game design


static func _static_init() -> void:
	
	if ( Engine.is_editor_hint() or CmdArgs.has_arg( CmdArgs.DEV_MODE ) ):
		dev_mode = true;


## If true, allow developer features
static var dev_mode: bool = false;


## Enum for listing the state of the screen fader.
enum ScreenFadeState {
	## Screen fader is hidden and idle.
	IDLE,
	## Screen fader is hiding the screen.
	FADING_IN,
	## Screen is hidden.
	HIDDEN,
	## Screen fader is showing the screen.
	FADING_OUT,
}
## Current state of the screen fader.
static var screen_fade_state: ScreenFadeState = ScreenFadeState.IDLE;
