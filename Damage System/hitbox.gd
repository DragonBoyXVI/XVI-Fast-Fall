@tool
extends StrippedArea2D;
class_name Hitbox;
## Node that detects if it has been hit in the damage system.
##
## ditto


const DEBUG_COLOR = Color( Color.BLUE, 0.625 );


## Emitted when this hitbox has been hit
signal took_damage( damage: int );
## Call to send damage via this hitbox
func take_damage( damage: int ) -> void:
	took_damage.emit( damage );


@export var _team: Consts.Team = Consts.Team.NONE;
func get_team() -> Consts.Team: return _team;


func _init() -> void:
	super()
	
	if ( Engine.is_editor_hint() ):
		return;
	
	monitorable = true;
	collision_layer = Consts.Collision.HITBOX;

func _shape_entered_tree( shape: CollisionShape2D ) -> void:
	shape.debug_color = DEBUG_COLOR;
