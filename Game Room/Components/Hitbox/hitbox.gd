@tool
extends StrippedArea2DGD;
class_name Hitbox;
## Area node that defines what area of an entity is damageable.
##
## did


const _DEBUG_COLOR := Color(0.0, 0.0, 1.0, 0.625);

enum _Flag {
	NONE = 0,
	PLAYER = 1<<0,
	ENEMY = 1<<1,
}


## Emitted when this takes damage, providing the damage instance.
signal took_damage( dmg: Damage );


## What team(s) this belongs to.
## Can be hit by anything targeting this team.
@export_flags( "Player", "Enemy" ) var _team: int = _Flag.ENEMY;


func _init() -> void:
	super();
	
	monitorable = true;

func _ready() -> void:
	super();
	
	if ( Engine.is_editor_hint() ):
		return;
	
	if ( _team & _Flag.PLAYER ):
		collision_layer |= Consts.Collision.PLAYER_HITBOX;
	if ( _team & _Flag.ENEMY ):
		collision_layer |= Consts.Collision.ENEMY_HITBOX;

func _shape_entered_tree( shape: CollisionShape2D ) -> void:
	shape.debug_color = _DEBUG_COLOR;


func take_damage( dmg: Damage ) -> void:
	
	took_damage.emit( dmg );

func enable() -> void:
	process_mode = Node.PROCESS_MODE_INHERIT;

func disable() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED;
