@abstract
@tool
extends Object;
class_name GameState;
## Tracks game wide state info
##
## game design


static func _static_init() -> void:
	print( "GameState init" );
	
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

## Enum for various game modes
enum GameMode {
	## Invalid game mode
	NONE,
	
	## Survive as many rounds as possible.
	## Rounds end after an amount of time.
	TIME_SURVIVAL,
	## Survive as many rounds as possible.
	## Rounds end whenn you hit a score quota.
	QUOTA_SURVIVAL,
	## Anything can spawn at any time. Enemies, bosses, upgrades.,.
	## Survive for as long as possible!
	ALL_OUT,
}
static var current_game_mode: GameMode = GameMode.NONE;


## The current score for this game.
static var current_score: int = 0;
