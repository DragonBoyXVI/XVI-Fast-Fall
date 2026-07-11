@tool
extends MovementComponent;
class_name PlayerMovement;


## The speed you move in pix/sec
@export var _move_speed: float = 400.0;

@export_group( "Dash", "_dash" )
## How many seconds the dash lasts
@export var _dash_duration: float = 0.2:
	set( new ):
		_dash_duration = maxf( 0.05, new );
## Speed multiplier thats active while dashing
@export var _dash_speed_mult: float = 1.5:
	set( new ):
		_dash_speed_mult = maxf( 0.05, new );


var _dash_timer: Timer;

var _last_moved_dir: Vector2 = Vector2.ZERO;
var _is_dashing: bool = false;


func _ready() -> void:
	super();
	
	if ( Engine.is_editor_hint() ):
		return;
	
	_dash_timer = CooldownTimer.new();
	_dash_timer.timeout.connect( _on_dash_timer_timeout, CONNECT_DEFERRED );
	add_child( _dash_timer, false, Node.INTERNAL_MODE_BACK );


func move( delta: float, dir: Vector2 ) -> void:
	
	if ( _is_dashing ):
		
		var move_vec: Vector2 = dir;
		if ( dir.is_zero_approx() ):
			move_vec = _last_moved_dir;
		else:
			_last_moved_dir = dir;
		
		move_vec *= delta * _move_speed * _dash_speed_mult;
		_target_node.translate( move_vec );
	else:
		
		if ( !dir.is_zero_approx() ):
			_last_moved_dir = dir.normalized();
		
		var movement_vec := dir * _move_speed * delta;
		_target_node.translate( movement_vec );
	
	const SCREEN_LIMIT := Vector2( Consts.SCREEN_SIZE );
	_target_node.position = _target_node.position.clamp( Vector2.ZERO, SCREEN_LIMIT );

func dash() -> void:
	if ( _is_dashing ): return;
	_is_dashing = true;
	
	_dash_timer.start( _dash_duration );


func _on_dash_timer_timeout() -> void:
	_is_dashing = false;
