@tool
extends StrippedArea2DGD;
class_name Hurtbox;
## An active hurtbox thatll send damage to anything that enters it.
## Best used for animated attacks for passive contact damage.
##
## doobie


const _DEBUG_COLOR := Color(1.0, 0.0, 0.0, 0.625);


## Emitted when a valid hitbox enters this area.
signal hitbox_entered( hitbox: Hitbox );


## What team(s) this targets and deals damage to.
@export var _target := Consts.Team.PLAYER;


func _init() -> void:
	super();
	
	monitoring = true;
	
	if ( Engine.is_editor_hint() ):
		return;
	
	area_entered.connect( _on_area_entered );

func _ready() -> void:
	super();
	
	if ( Engine.is_editor_hint() ):
		return;
	
	if ( _target & Consts.Team.PLAYER ):
		collision_mask |= Consts.Collision.PLAYER_HITBOX;
	if ( _target & Consts.Team.ENEMY ):
		collision_mask |= Consts.Collision.ENEMY_HITBOX;

func _shape_entered_tree( shape: CollisionShape2D ) -> void:
	shape.debug_color = _DEBUG_COLOR;


func _on_area_entered( area: Area2D ) -> void:
	if ( area is Hitbox ):
		hitbox_entered.emit( area );
