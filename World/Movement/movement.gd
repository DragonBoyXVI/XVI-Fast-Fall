@abstract
@tool
extends Node;
class_name MovementComponent;
## Node dedicated to movementlogic.
##
## ditto


## The node this moves.
@export var _movable_node: Node2D:
	set( new ):
		_movable_node = new;
		update_configuration_warnings();


func _ready() -> void:
	
	if ( Engine.is_editor_hint() ):
		XVIFuncs.set_node_processes( self, false );
		return;

func _get_configuration_warnings() -> PackedStringArray:
	var warnings := PackedStringArray();
	
	if ( not _movable_node ):
		warnings.append( "No node set for this to move!" );
	
	return warnings;
