extends Node2D;


enum PState {
	FREE,
	DASH
}


const BULLET_SCENE: PackedScene = preload( "uid://b05smqo7otih0" );


@export var _speed: float = 400.0;

@export_group( "Dashing", "_dash" )
@export var _dash_duration: float = 0.125;
@export var _dash_mult: float = 3.0;
@export var _dash_cooldown: float = 2.0;

@export_group( "" )
@export var _damage_immune_time: float  = 1.0:
	set( new ):
		_damage_immune_time = maxf( 0.05, new );
@export var _time_between_shots: float = 0.125:
	set( new ):
		_time_between_shots = maxf( 0.05, new );

@export_group( "Components" )
@export var _health_node: HealthNode


var _state: PState = PState.FREE;


var _can_dash: bool = true;
var _can_shoot: bool = true;

var _dash_duration_timer: Timer;
var _dash_cooldown_timer: Timer;
var _shoot_cooldown_timer: Timer;

var _damage_immune_timer: Timer;
var _is_damage_immune: bool = false;


func _ready() -> void:
	
	_health_node.died.connect( _on_health_node_died );
	
	_dash_duration_timer = CooldownTimer.new();
	add_child( _dash_duration_timer, false, Node.INTERNAL_MODE_BACK );
	_dash_duration_timer.timeout.connect( _on_dash_duration_timer_timeout, CONNECT_DEFERRED )
	
	_dash_cooldown_timer = CooldownTimer.new();
	add_child( _dash_cooldown_timer, false, Node.INTERNAL_MODE_BACK );
	_dash_cooldown_timer.timeout.connect( _on_dash_cooldown_timer_timeout, CONNECT_DEFERRED )
	
	_shoot_cooldown_timer = CooldownTimer.new();
	add_child( _shoot_cooldown_timer, false, Node.INTERNAL_MODE_BACK );
	_shoot_cooldown_timer.timeout.connect( _on_shoot_cooldown_timer_timeout, CONNECT_DEFERRED );
	
	_damage_immune_timer = CooldownTimer.new();
	add_child( _damage_immune_timer, false, Node.INTERNAL_MODE_BACK );
	_damage_immune_timer.timeout.connect( _on_damage_immune_timer_timeout, CONNECT_DEFERRED );

func _process( _delta: float ) -> void:
	
	if ( _is_damagable() ):
		modulate = Color.WHITE;
	else:
		modulate = Color.REBECCA_PURPLE;

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

func _shoot() -> void:
	if ( not _can_shoot ): return
	
	_can_shoot = false;
	_shoot_cooldown_timer.start( _time_between_shots );
	
	var bullet: Node2D = BULLET_SCENE.instantiate();
	add_sibling( bullet );
	bullet.global_position = global_position;
	bullet.reset_physics_interpolation();


func _is_damagable() -> bool:
	if ( _state == PState.DASH ): return false;
	if ( _is_damage_immune ): return false;
	
	return true;


func _on_dash_duration_timer_timeout() -> void:
	_state = PState.FREE;

func _on_dash_cooldown_timer_timeout() -> void:
	_can_dash = true;

func _on_shoot_cooldown_timer_timeout() -> void:
	_can_shoot = true;


func _on_hitbox_took_damage( damage: int ) -> void:
	if ( not _is_damagable() ): return;
	
	_health_node.damage( damage );
	_is_damage_immune = true;
	_damage_immune_timer.start( _damage_immune_time );

func _on_health_node_died() -> void:
	queue_free();


func _on_damage_immune_timer_timeout() -> void:
	_is_damage_immune = false;
