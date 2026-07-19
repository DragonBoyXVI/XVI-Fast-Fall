@tool
extends StrippedArea2D;
class_name Hurtbox;
## Node that looks for [Hitbox]es and emits damage events over the damage
## system.
##
## pens


const DEBUG_COLOR := Color( Color.RED, 0.625 );


## Emitted when this hits a valid hitbox
signal found_hitbox( hitbox: Hitbox );


@export var _team: Consts.Team = Consts.Team.NONE;
func get_team() -> Consts.Team: return _team;


func _init() -> void:
	super();
	
	if ( Engine.is_editor_hint() ):
		return;
	
	monitoring = true;
	collision_mask = Consts.Collision.HITBOX;
	
	area_entered.connect( _on_area_entered );

func _shape_entered_tree( shape: CollisionShape2D ) -> void:
	shape.debug_color = DEBUG_COLOR;


func _on_area_entered( area: Area2D ) -> void:
	if ( area is not Hitbox ): return;
	var hitbox: Hitbox = area;
	
	if ( _team == Consts.Team.NONE or _team != hitbox.get_team() ):
		found_hitbox.emit( hitbox );
