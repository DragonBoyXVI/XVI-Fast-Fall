@tool
extends MovementNode;
class_name PlayerMovement;
## Node that allows the player to move the selected node.
##
## use ur keybrd =3


## Base movement speed.
@export var _speed: float = 600.0;


var _speed_mult: float = 1.0;
var _speed_timer: Timer;


func _ready() -> void:
	super()
	
	if ( Engine.is_editor_hint() ):
		return;
	
	_speed_timer = Timer.new();
	_speed_timer.one_shot = true;
	_speed_timer.process_callback = Timer.TIMER_PROCESS_PHYSICS;
	add_child( _speed_timer, false, Node.INTERNAL_MODE_BACK );

func _physics_process( delta: float ) -> void:
	
	var move_dir: Vector2 = InputNames.get_move_dir();
	var move_vec: Vector2 = move_dir * _speed * _speed_mult * delta;
	_actor.translate( move_vec );
	_actor.global_position = _actor.global_position.clamp(
		Vector2.ZERO,
		Consts.SCREEN_SIZE
	);


func dash_speed_boost( time: float, speed: float ) -> void:
	
	_speed_mult *= speed;
	_speed_timer.start( time );
	await _speed_timer.timeout;
	_speed_mult /= speed;
