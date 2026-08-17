extends QuotaTracker;
class_name QuotaScore;


const BASE_SCORE: int = 10;


var _min_score: int = 0;
var _should_check: bool = true;


func _ready() -> void:
	
	_min_score = ceili( BASE_SCORE * GameState.difficulty );

func _physics_process( _delta: float ) -> void:
	if (  _should_check and _min_score <= GameState.get_quota_score() ):
		_should_check = false;
		notifty_quota_done();
