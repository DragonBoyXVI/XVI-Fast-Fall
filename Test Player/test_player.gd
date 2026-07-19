extends Node2D;


enum PState {
	FREE,
	DASH
}


const BULLET_SCENE: PackedScene = preload( "uid://b05smqo7otih0" );


@export var _speed: float = 400.0;
@export var _dash_duration: float = 0.125;
@export var _dash_mult: float = 3.0;
@export var _dash_cooldown: float = 2.0;
@export var _time_between_shots: float = 0.125;


var _state: PState = PState.FREE;

var _hp := 5;

var _can_dash: bool = true;
var _can_shoot: bool = true;

var _dash_duration_timer: Timer;
var _dash_cooldown_timer: Timer;
var _shoot_cooldown_timer: Timer;


func _ready() -> void:
	
	_dash_duration_timer = CooldownTimer.new();
	add_child( _dash_duration_timer, false, Node.INTERNAL_MODE_BACK );
	_dash_duration_timer.timeout.connect( _on_dash_duration_timer_timeout, CONNECT_DEFERRED )
	
	_dash_cooldown_timer = CooldownTimer.new();
	add_child( _dash_cooldown_timer, false, Node.INTERNAL_MODE_BACK );
	_dash_cooldown_timer.timeout.connect( _on_dash_cooldown_timer_timeout, CONNECT_DEFERRED )
	
	_shoot_cooldown_timer = CooldownTimer.new();
	add_child( _shoot_cooldown_timer, false, Node.INTERNAL_MODE_BACK );
	_shoot_cooldown_timer.timeout.connect( _on_shoot_cooldown_timer_timeout, CONNECT_DEFERRED );

func _physics_process( delta: float ) -> void:
	
	if ( _state == PState.FREE ):
		_routine_movement( delta, InputNames.get_move_dir() );
		
		if ( Input.is_action_pressed( InputNames.BACK ) ):
			_do_dash();
		
		if ( Input.is_action_pressed( InputNames.ENTER ) ):
			_shoot();
	elif ( _state == PState.DASH ):
		_routine_movement( delta * _dash_mult, InputNames.get_move_dir() );


func _routine_movement( delta: float, direction: Vector2 ) -> void:
	var movement: Vector2 = delta * _speed * direction;
	translate( movement );
	position = position.clamp( Vector2.ZERO, Consts.SCREEN_SIZE );

func _do_dash() -> void:
	if ( not _can_dash ): return;
	
	_can_dash = false;
	_state = PState.DASH;
	_dash_duration_timer.start( _dash_duration );
	_dash_cooldown_timer.start( _dash_cooldown );
	
	modulate = Color.REBECCA_PURPLE;

func _shoot() -> void:
	if ( not _can_shoot ): return
	
	_can_shoot = false;
	_shoot_cooldown_timer.start( _time_between_shots );
	
	var bullet: Node2D = BULLET_SCENE.instantiate();
	add_sibling( bullet );
	bullet.global_position = global_position;
	bullet.reset_physics_interpolation();


func _on_dash_duration_timer_timeout() -> void:
	_state = PState.FREE;
	modulate = Color.WHITE;

func _on_dash_cooldown_timer_timeout() -> void:
	_can_dash = true;

func _on_shoot_cooldown_timer_timeout() -> void:
	_can_shoot = true;


func _on_hitbox_took_damage( damage: int ) -> void:
	if ( _state == PState.DASH ): return;
	
	_hp -= damage;
	if ( _hp <= 0 ):
		queue_free();
	
	print( _hp );
