@tool
extends Node2D;
class_name Player;


# maybe move shooting here again?
# gives the player itself more control over shooting.,.,


@export var _iframe_time: float = 0.0;
@export_group( "Components" )
@export var _health: HealthNode;
@export var _hitbox: Hitbox;
@export var _movement: PlayerMovement;
@export var _shooter: Shooter;

@export_group( "Dash" )
## How long you have to wait to dash again after dashing.
@export var _dash_cooldown: float = 2.0;
## How long the speed buff from dashing lasts.
@export var _dash_speed_duration: float = 0.5;
## Speed multiplier after dashing.
@export var _dash_speed_mult: float = 1.5;
## How long the iframes from dashing lasts
@export var _dash_iframe_duration: float = 0.5;


var _can_dash := true;
var _dash_timer: Timer;


func _init() -> void:
	
	z_index = Consts.ZLayers.PLAYER;
	
	if ( Engine.is_editor_hint() ):
		return;

func _ready() -> void:
	
	if ( Engine.is_editor_hint() ):
		
		XVIFuncs.disable_node_processes( self );
		return;
	
	
	_dash_timer = Timer.new();
	_dash_timer.process_callback = Timer.TIMER_PROCESS_PHYSICS;
	_dash_timer.one_shot = true;
	_dash_timer.timeout.connect(
		func() -> void: _can_dash = true,
		CONNECT_DEFERRED
	);
	add_child( _dash_timer, false, Node.INTERNAL_MODE_BACK );
	
	
	if ( _health ):
		_health.died.connect( _die );
	
	if ( _hitbox ):
		_hitbox.took_damage.connect( _on_hitbox_took_damage );

func _validate_property( property: Dictionary ) -> void:
	FFFuncs.disable_prop_2ds( property );

func _physics_process( _delta: float ) -> void:
	
	if ( Input.is_action_pressed( InputNames.ENTER ) ):
		_shooter.shoot();
	
	if ( Input.is_action_just_pressed( InputNames.BACK ) ):
		_dash();


func _dash() -> void:
	if ( not _can_dash ): return;
	_can_dash = false;
	
	_movement.dash_speed_boost( _dash_speed_duration, _dash_speed_mult );
	_hitbox.start_iframes( _dash_iframe_duration );
	_dash_timer.start( _dash_cooldown );

func _die() -> void:
	queue_free();
	print( "You died!" );


func _on_hitbox_took_damage( dmg: Damage ) -> void:
	
	_health.take_damage( dmg );
	if ( _iframe_time > 0.0 ):
		_hitbox.start_iframes( _iframe_time );
