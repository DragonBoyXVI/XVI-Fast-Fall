@tool
extends StrippedArea2D;
class_name Hurtbox2D;
## Active area that hurts any [Hitbox]es entering this area.
## unless theyre on the same team.
##
## ditt0


const DEBUG_COLOR := Color( 1.0, 0.0, 0.0, .625 );


## Emitted when a hurtable hitbox enters this [Hurtbox].
signal hitbox_entered( hitbox: Hitbox2D );


## The team this hitbox belongs to.
@export var _team: Consts.Team = Consts.Team.NONE;


func _init() -> void:
	super();
	
	if ( Engine.is_editor_hint() ):
		return;
	
	area_entered.connect( _on_area_entered );
	
	monitoring = true;

func _ready() -> void:
	super();
	
	if ( Engine.is_editor_hint() ):
		return;
	
	match _team:
		
		Consts.Team.ALL:
			collision_mask = Consts.Collision.PLAYER_HITBOX | Consts.Collision.ENEMY_HITBOX;
		
		Consts.Team.PLAYER:
			collision_mask = Consts.Collision.ENEMY_HITBOX;
		
		Consts.Team.ENEMY:
			collision_mask = Consts.Collision.PLAYER_HITBOX;
		
		_: pass;

func _shape_entered_tree( shape: CollisionShape2D ) -> void:
	shape.debug_color = DEBUG_COLOR;


func _on_area_entered( area: Area2D ) -> void:
	if ( area is not Hitbox2D ): return;
	var hitbox := area as Hitbox2D;
	if ( not hitbox.get_team() & _team ):
		hitbox_entered.emit( hitbox );


func get_team() -> Consts.Team:
	return _team;
