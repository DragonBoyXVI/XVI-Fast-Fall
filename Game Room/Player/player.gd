@tool
extends Node2D;
class_name Player;


const _SPEED := 300.0;


@export var _hitbox: Hitbox;


var _hp := 5;


func _init() -> void:
	
	z_index = Consts.ZLayers.PLAYER;
	
	if ( Engine.is_editor_hint() ):
		return;

func _ready() -> void:
	
	if ( Engine.is_editor_hint() ):
		
		XVIFuncs.disable_node_processes( self );
		return;
	
	_hitbox.took_damage.connect( _on_hitbox_took_damage );

func _validate_property( property: Dictionary ) -> void:
	FFFuncs.disable_prop_2ds( property );

func _physics_process( delta: float ) -> void:
	
	var move_vec := InputNames.get_move_dir();
	position += move_vec * _SPEED * delta;
	
	position = position.clamp( Vector2.ZERO, Consts.SCREEN_SIZE );


func _on_hitbox_took_damage( dmg: Damage ) -> void:
	
	print( "Ouch! took %s damage!" % dmg.amount );
	_hp -= dmg.amount;
	
	if ( _hp <= 0 ):
		queue_free();
