@tool
@abstract
extends Node;
class_name MovementComponent;
## Base class for movement nodes.
##
## ditto


## The [Node2D] this moves.
@export var _target_node: Node2D:
	set( new ):
		_target_node = new;
		update_configuration_warnings();


func _ready() -> void:
	
	if ( Engine.is_editor_hint() ):
		XVIFuncs.set_node_processes( self, false );
		return;

func _get_configuration_warnings() -> PackedStringArray:
	var warnings := PackedStringArray();
	
	if ( not _target_node ):
		warnings.append( "No target node for this to move!" );
	
	return warnings;


@abstract func move( delta: float, dir: Vector2 ) -> void;
