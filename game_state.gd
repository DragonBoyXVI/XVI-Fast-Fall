@abstract
@tool
extends Object;
class_name GameState;


## If true, dev related drawing and tools are exposed.
static var dev_mode: bool = false;


static func _static_init() -> void:

	if ( Engine.is_editor_hint() ):
		return;

	dev_mode = CmdArgs.has_arg( CmdArgs.DEV_MODE );


## Counts how many things are being loaded
static var things_loading: int = 0;


static var _total_game_score: int = 0;
## This is the scare saved to a leaderboard
static func get_game_total_scrore() -> int:
	return _total_game_score;

static var _quota_score: int = 0;
static func get_quota_score() -> int:
	return _quota_score;
static func reset_quota_score() -> void:
	_quota_score = 0;

static func add_score( amt: int ) -> void:
	
	_total_game_score += amt;
	_quota_score += amt;


static var difficulty: float = 1.0;
