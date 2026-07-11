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


func _init() -> void:
	super();
	
	if ( Engine.is_editor_hint() ):
		return;
	
	monitorable = true;

func _ready() -> void:
	super();
	
	if ( Engine.is_editor_hint() ):
		return;
	
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
