@tool
extends StrippedArea2DGD;
class_name Hitbox;
## Area node that defines what area of an entity is damageable.
##
## did


const _DEBUG_COLOR := Color(0.0, 0.0, 1.0, 0.625);


## Emitted when this takes damage, providing the damage instance.
signal took_damage( dmg: Damage );


## What team(s) this belongs to.
## Can be hit by anything targeting this team.
@export var _team := Consts.Team.ENEMY;


var _iframe_timer: Timer;


func _init() -> void:
	super();
	
	monitorable = true;

func _ready() -> void:
	super();
	
	if ( Engine.is_editor_hint() ):
		return;
	
	if ( _team & Consts.Team.PLAYER ):
		collision_layer |= Consts.Collision.PLAYER_HITBOX;
	if ( _team & Consts.Team.ENEMY ):
		collision_layer |= Consts.Collision.ENEMY_HITBOX;
	
	_iframe_timer = Timer.new();
	_iframe_timer.process_mode = Node.PROCESS_MODE_PAUSABLE;
	_iframe_timer.process_callback = Timer.TIMER_PROCESS_PHYSICS;
	_iframe_timer.one_shot = true;
	_iframe_timer.timeout.connect( enable, CONNECT_DEFERRED );
	add_child( _iframe_timer, false, Node.INTERNAL_MODE_BACK );

func _shape_entered_tree( shape: CollisionShape2D ) -> void:
	shape.debug_color = _DEBUG_COLOR;


func take_damage( dmg: Damage ) -> void:
	
	took_damage.emit( dmg );


func enable() -> void:
	process_mode = Node.PROCESS_MODE_INHERIT;

func disable() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED;

func start_iframes( time: float ) -> void:
	
	disable.call_deferred();
	_iframe_timer.start( time );
