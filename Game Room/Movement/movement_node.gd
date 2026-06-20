@tool
@abstract
extends Node;
class_name MovementNode;
## Base class for various types of movement.
##
## Moveo


## The node we wish to move with this.
@export var _actor: Node2D:
	set( new ):
		_actor = new;
		update_configuration_warnings();


func _ready() -> void:
	
	if ( Engine.is_editor_hint() ):
		
		XVIFuncs.disable_node_processes( self );
		return;

func _get_configuration_warnings() -> PackedStringArray:
	var warnings := PackedStringArray();
	
	if ( not _actor ):
		warnings.append( "Please provide this node with an actor!" );
	
	return warnings;
