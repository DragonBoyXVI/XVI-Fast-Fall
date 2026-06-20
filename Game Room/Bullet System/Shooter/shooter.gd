@tool
extends Node2D;
class_name Shooter;


const _DEBUG_ARROW_DIST := 32.0;


## Team of the spawned bulled.
@export var _team := Consts.Team.ENEMY;
## The direction the bullet is shot in. Drawn as a red line in editor.
@export_range( 0.0, 360.0, 1.0, "radians_as_degrees" ) var _shoot_dir: float = 0.0:
	set( new ):
		_shoot_dir = new;
		queue_redraw();
## Damage the bullet deals.
@export var _damage: int = 1;
## How much time must pass before you can shoot again.
@export var _seconds_per_shot: float = 0.25;
## How fast the bullet travels in pix/sec.
@export var _bullet_speed: float = 600.0;
## How many times this bullet can deal damage before disapearing.
@export var _bullet_collisions: int = 1:
	set( new ):
		_bullet_collisions = maxi( 1, new );


var _timer: Timer;
var _can_shoot := true;


func _ready() -> void:
	
	if ( Engine.is_editor_hint() ):
		return;
	
	_timer = Timer.new();
	_timer.process_callback = Timer.TIMER_PROCESS_PHYSICS;
	_timer.one_shot = true;
	_timer.timeout.connect( func() -> void: _can_shoot = true, CONNECT_DEFERRED );
	add_child( _timer );

func _draw() -> void:
	if ( not Engine.is_editor_hint() ):
		return;
	
	var line_vec := Vector2.from_angle( _shoot_dir ) * _DEBUG_ARROW_DIST;
	draw_line( Vector2.ZERO, line_vec, Color.RED );


func shoot() -> void:
	
	if ( _can_shoot ):
		
		_can_shoot = false;
		_timer.start( _seconds_per_shot );
		
		var damage := Damage.new( _damage );
		
		var bullet := BulletStandard.new();
		bullet.team = _team;
		bullet.transform.origin = global_position;
		bullet.transform = bullet.transform.rotated_local( _shoot_dir );
		bullet.damage = damage;
		bullet.speed = _bullet_speed;
		bullet.max_collisions = _bullet_collisions
		
		Radio.fire_bullet( bullet );
