@tool
extends Node2D;
class_name Player;


const _SPEED := 300.0;


func _init() -> void:
	
	z_index = Consts.ZLayers.PLAYER;
	
	if ( Engine.is_editor_hint() ):
		return;

func _ready() -> void:
	
	if ( Engine.is_editor_hint() ):
		
		XVIFuncs.disable_node_processes( self );
		return;

func _validate_property( property: Dictionary ) -> void:
	FFFuncs.disable_prop_2ds( property );

func _physics_process( delta: float ) -> void:
	
	var move_vec := InputNames.get_move_dir();
	position += move_vec * _SPEED * delta;
	
	position = position.clamp( Vector2.ZERO, Consts.SCREEN_SIZE );
