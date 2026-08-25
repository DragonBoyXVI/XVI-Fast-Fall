@tool
extends PlayerState;


const LOWER_POINT_TARGET: float = Consts.SCREEN_SIZE.y * 0.2;
const SPAWN_SPOT: Vector2= Vector2(
	Consts.SCREEN_SIZE.x * 0.5,
	-600.0
);


func _enter_state() -> void:
	
	_player.position = SPAWN_SPOT;
	_player.reset_physics_interpolation();

func _leave_state() -> void:
	Radio.emit_start_round();


func _physics_process( delta: float ) -> void:
	
	const BASE_SPEED := 200.0;
	const MAX_SPEED := 600.0;
	var move_speed := BASE_SPEED * GameState.difficulty;
	move_speed = clampf( move_speed, BASE_SPEED, MAX_SPEED );
	_player.routine_movement( delta, Vector2.DOWN, 200.0 );
	
	if ( _player.position.y >= LOWER_POINT_TARGET ):
		
		_player.position.y = LOWER_POINT_TARGET;
		emit_state_change_request( Player.STATE_FREE );
