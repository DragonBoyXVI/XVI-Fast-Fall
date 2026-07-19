@tool
extends StrippedArea2D;
class_name Hitbox2D;
## Node that gives the ability to take damage
##
## ditto


const DEBUG_COLOR := Color( 0.0, 0.0, 1.0, .625 );


## Emitted when this takes damage.
signal took_damage( damage: DamageInst );


@export var _team: Consts.Team = Consts.Team.NONE;


var _disable_timer: Timer;


func _init() -> void:
	super();
	
	if ( Engine.is_editor_hint() ):
		return;
	
	monitorable = true;

func _ready() -> void:
	super();
	
	if ( Engine.is_editor_hint() ):
		return;
	
	_disable_timer = Timer.new();
	_disable_timer.process_mode = Node.PROCESS_MODE_PAUSABLE;
	_disable_timer.process_callback = Timer.TIMER_PROCESS_PHYSICS;
	_disable_timer.one_shot = true;
	add_child( _disable_timer, false, Node.INTERNAL_MODE_BACK );
	_disable_timer.timeout.connect( _on_disable_timer_timeout, CONNECT_DEFERRED );
	
	match _team:
		
		Consts.Team.ALL:
			collision_layer = Consts.Collision.PLAYER_HITBOX | Consts.Collision.ENEMY_HITBOX;
		
		Consts.Team.PLAYER:
			collision_layer = Consts.Collision.PLAYER_HITBOX;
		
		Consts.Team.ENEMY:
			collision_layer = Consts.Collision.ENEMY_HITBOX;
		
		_: pass;

func _shape_entered_tree( shape: CollisionShape2D ) -> void:
	shape.debug_color = DEBUG_COLOR;


func get_team() -> Consts.Team:
	return _team;

func take_damage( damage: DamageInst ) -> void:
	took_damage.emit( damage );

func timed_disable( time: float ) -> void:
	
	set_deferred( &"process_mode", Node.PROCESS_MODE_DISABLED );
	_disable_timer.start( time );

# deferred
func _on_disable_timer_timeout() -> void:
	process_mode = Node.PROCESS_MODE_INHERIT;
