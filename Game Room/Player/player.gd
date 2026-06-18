@tool
extends Node2D;
class_name Player;


# maybe move shooting here again?
# gives the player itself more control over shooting.,.,


@export_group( "Stats" )
## Base unscaled movement speed in pix/sec
@export var _move_speed: float = 300.0;

@export_subgroup( "Shooting", "_shoot" )
## The node whos global transform is used to determine where the bullet spawns.
## If you overwrite _shoot() than this may not matter.
@export var _shoot_bullet_marker: Marker2D;
## How many seconds must pass before you can shoot again.
@export var _shoot_time_per_shot: float = 0.25:
	set( new ):
		_shoot_time_per_shot = maxf( 0.05, new );
## Base damage a shot deals.
@export var _shoot_damage: int = 1;
## Base speed of your bullets (pix/sec).
@export var _shoot_speed: float = 600.0;

@export_subgroup( "Dash", "_dash" )
## Multiplier for move speed while dashing.
@export var _dash_speed_mult: float = 1.5;
## How long the speed from dashing lasts (sec).
@export var _dash_speed_time: float = 0.5:
	set( new ):
		_dash_speed_time = maxf( 0.0, new );
## How long dash invincibility lasts (sec).
@export var _dash_iframes_time: float = 0.25:
	set( new ):
		_dash_iframes_time = maxf( 0.0, new );

@export_group( "Components" )
@export var _health: HealthNode;
@export var _hitbox: Hitbox;


var _shoot_timer: Timer;
var _can_shoot: bool = true;


func _init() -> void:
	
	z_index = Consts.ZLayers.PLAYER;
	
	if ( Engine.is_editor_hint() ):
		return;

func _ready() -> void:
	
	if ( Engine.is_editor_hint() ):
		
		XVIFuncs.disable_node_processes( self );
		return;
	
	_shoot_timer = Timer.new();
	_shoot_timer.one_shot = true;
	_shoot_timer.process_callback = Timer.TIMER_PROCESS_PHYSICS;
	add_child( _shoot_timer, false, Node.INTERNAL_MODE_BACK );
	_shoot_timer.timeout.connect( _on_shoot_timer_timeout, CONNECT_DEFERRED );
	
	if ( _health ):
		_health.died.connect( queue_free );
	
	if ( _hitbox ):
		_hitbox.took_damage.connect( _on_hitbox_took_damage );

func _validate_property( property: Dictionary ) -> void:
	FFFuncs.disable_prop_2ds( property );

func _physics_process( delta: float ) -> void:
	
	_routine_movement( delta, InputNames.get_move_dir() );
	if ( Input.is_action_pressed( InputNames.ENTER ) ):
		_routine_shooting();
	
	if ( Input.is_action_pressed( InputNames.ENTER ) ):
		pass


func _routine_movement( delta: float, direction: Vector2 ) -> void:
	position += direction * _move_speed * delta;
	position = position.clamp( Vector2.ZERO, Consts.SCREEN_SIZE );

func _routine_shooting() -> void:
	if ( _can_shoot ):
		_can_shoot = false;
		_shoot_timer.start( _shoot_time_per_shot );
		_shoot();


func _die() -> void:
	queue_free();
	print( "You died!" )

func _shoot() -> void:
	var bullet := BulletStandard.new();
	bullet.transform = Transform2D.IDENTITY.rotated( PI * 0.5 );
	bullet.transform.origin = global_position;
	
	bullet.team = Consts.Team.PLAYER;
	
	bullet.damage = Damage.new( _shoot_damage );
	bullet.speed = _shoot_speed;
	
	Radio.fire_bullet( bullet );


func _on_hitbox_took_damage( dmg: Damage ) -> void:
	_health.take_damage( dmg );

func _on_shoot_timer_timeout() -> void:
	_can_shoot = true;
