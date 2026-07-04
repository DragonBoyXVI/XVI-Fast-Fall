@tool
extends Node2D


enum PlayerState {
	FREE,
	DASHING,
	SHOOTING,
}


## Movement speed in pix/sec.
@export var _move_speed: float = 400.0;

## How long you have to wait to dash again after dashing.
@export var _dash_cooldown: float = 2.0;
## How long you stay in the dash state.
## While in the state, youre forced to move and cannot shoot.
@export var _dash_state_duration: float = 0.25;
## How much faster/slower dashing is.
@export var _dash_speed_mult: float = 1.5;


var _state: PlayerState = PlayerState.FREE;
var _last_move_dir: Vector2 = Vector2.ZERO;

var _dash_cooldown_timer: Timer;
var _dash_state_timer: Timer;
var _can_dash := true;


func _ready() -> void:
	
	if ( Engine.is_editor_hint() ):
		XVIFuncs.set_node_processes( self, false );
		return;
	
	_dash_state_timer = CooldownTimer.new();
	_dash_state_timer.timeout.connect( _on_dash_state_timer_timeout );
	add_child( _dash_state_timer, false, Node.INTERNAL_MODE_BACK );
	
	_dash_cooldown_timer = CooldownTimer.new();
	_dash_cooldown_timer.timeout.connect( _on_dash_cooldown_timer_timeout );
	add_child( _dash_cooldown_timer, false, Node.INTERNAL_MODE_BACK );

func _physics_process( delta: float ) -> void:
	
	if ( _state == PlayerState.FREE ):
		
		var move_dir := InputNames.get_move_dir();
		if ( not move_dir.is_zero_approx() ):
			_last_move_dir = move_dir.normalized();
		_routine_movement( delta, move_dir );
		
		if ( Input.is_action_pressed( InputNames.BACK ) ):
			_dash();
		
	elif ( _state == PlayerState.DASHING ):
		
		# normalize here to enure no partial movement
		var move_dir := InputNames.get_move_dir().normalized();
		if ( move_dir.is_zero_approx() ):
			move_dir = _last_move_dir
		else:
			_last_move_dir = move_dir;
		
		_routine_movement( delta, move_dir * _dash_speed_mult );


func _routine_movement( delta: float, direction: Vector2 ) -> void:
	
	var move_offset: Vector2 = direction * delta * _move_speed;
	translate( move_offset );
	
	const MOVE_LIMIT := Vector2( Consts.SCREEN_SIZE );
	position = position.clamp( Vector2.ZERO, MOVE_LIMIT );


func _dash() -> void:
	_state = PlayerState.DASHING;
	_dash_state_timer.start( _dash_state_duration );


func _on_dash_state_timer_timeout() -> void:
	
	if ( _state != PlayerState.SHOOTING ):
		_state = PlayerState.FREE;

func _on_dash_cooldown_timer_timeout() -> void:
	
	_can_dash = true;
