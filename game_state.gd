@abstract
@tool
extends Object;
class_name GameState;


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
