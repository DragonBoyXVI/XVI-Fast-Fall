@tool
extends StrippedArea2D;
class_name Hitbox;
## Node that allows a scene to take damage
##
## emits the "was_hit" signal after another node calls "take_hit" on this.


## Color of this's editor shapes.
const SHAPE_COLOR = Color( Color.SKY_BLUE, 0.625 );


## Emitted when this takes damage.[br]
## dmg: [DamageInst] - The damage this took.
signal was_hit( dmg: DamageInst );
func take_hit( dmg: DamageInst ) -> void:
	was_hit.emit( dmg );


## What team this [Hitbox] belongs to.
## This is only read once at ready-time. After that you can just change
## The collision layer to change its target.
@export var _team: Consts.Team = Consts.Team.NONE;


## Gets collision layers representing a team hitbox.
static func collision_layers_from_team( team: Consts.Team ) -> int:
	match team:
		Consts.Team.ALL: return Consts.Collision.ALL_HITBOXES;
		Consts.Team.PLAYER: return Consts.Collision.PLAYER_HITBOX;
		Consts.Team.ENEMY: return Consts.Collision.ENEMY_HITBOX;
		_: return 0;


func _init() -> void:
	super();
	
	monitorable = true;

func _ready() -> void:
	super();
	
	if ( Engine.is_editor_hint() ):
		return;
	
	collision_layer = collision_layers_from_team( _team );
	
	Radio.bullet_hit_hitbox.connect( _on_radio_bullet_hit_hitbox, CONNECT_DEFERRED );

func _shape_entered_tree( shape: CollisionShape2D ) -> void:
	shape.debug_color = SHAPE_COLOR;


func _on_radio_bullet_hit_hitbox( hitbox_rid: RID, damage: DamageInst ) -> void:
	if ( hitbox_rid == get_rid() ):
		take_hit( damage );
