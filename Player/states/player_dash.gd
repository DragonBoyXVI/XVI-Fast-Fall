@tool
extends PlayerState;


enum DashType {
	SPOT,
	DIRECTION,
}


@export var _dash_speed: float = 700.0;
@export var _duration: float = 0.125;
@export var _hitbox: Hitbox;


## Used to end the dash after some time
var _dash_timer: Timer;

var _dash_type: DashType;
var _dash_dir: Vector2;


func _ready() -> void:
	super();
	
	if ( Engine.is_editor_hint() ):
		return;
	
	_dash_timer = Timer.new();
	add_child( _dash_timer, false, Node.INTERNAL_MODE_BACK );
	_dash_timer.process_callback = Timer.TIMER_PROCESS_PHYSICS;
	_dash_timer.one_shot = true;
	_dash_timer.timeout.connect( _on_dash_timer_timeout );

func _physics_process( delta: float ) -> void:
	
	if ( _dash_type == DashType.SPOT ):
		pass;
	else:
		_player.routine_movement( delta, _dash_dir, _dash_speed );


func _enter_state() -> void:
	_hitbox.set_deferred( &"process_mode", PROCESS_MODE_DISABLED );
	_dash_timer.start( _duration );
	
	var input_dir := InputNames.get_move_dir();
	if ( input_dir.is_zero_approx() ):
		
		_dash_type = DashType.SPOT;
	else:
		
		_dash_type = DashType.DIRECTION;
		_dash_dir = input_dir.normalized();

func _leave_state() -> void:
	_hitbox.set_deferred( &"process_mode", PROCESS_MODE_INHERIT );
	_dash_timer.stop();


func _on_dash_timer_timeout() -> void:
	if ( not can_process() ): return;
	
	emit_state_change_request( Player.STATE_FREE );
