@tool
extends StrippedArea2D;
class_name Hurtbox;
## Node that allows a scene to detect [Hitbox] nodes.
##
## Looks for [Hitbox] nodes and emits the "found_hitbox" signal when it finds one.


const SHAPE_COLOR: Color = Color( Color.ORANGE_RED, 0.625 );


## Emitted when this detects a hitbox.
signal found_hitbox( hitbox: Hitbox );


## What team this [Hurtbox] belongs to.
## This is only read once at ready-time. After that you can just change
## The collision mask to change its target.
@export var _team: Consts.Team = Consts.Team.NONE;


## Gets collision layers representing a team hurtbox.
static func collision_mask_from_team( team: Consts.Team ) -> int:
	match team:
		Consts.Team.NONE: return Consts.Collision.ALL_HITBOXES;
		Consts.Team.ALL: return 0;
		Consts.Team.ENEMY: return Consts.Collision.PLAYER_HITBOX;
		Consts.Team.PLAYER: return Consts.Collision.ENEMY_HITBOX;
		
		_: return 0;


func _init() -> void:
	super();
	
	monitoring = true;

func _ready() -> void:
	super();
	
	if ( Engine.is_editor_hint() ):
		return;
	
	collision_mask = collision_mask_from_team( _team );
	
	area_entered.connect( _on_area_entered );

func _shape_entered_tree( shape: CollisionShape2D ) -> void:
	shape.debug_color = SHAPE_COLOR;


func _on_area_entered( area: Area2D ) -> void:
	if ( area is Hitbox ):
		found_hitbox.emit( area );
