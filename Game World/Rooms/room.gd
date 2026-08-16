@tool
extends Node2D;
class_name Room;
## Base class for game rooms.
##
## dito


## If true, rooms pause themselves on ready.
static var autopause: bool = false;



func _ready() -> void:
	
	if ( Engine.is_editor_hint() ):
		XVIFuncs.set_node_processes( self, false );
		return;
	
	if ( autopause ):
		pause.call_deferred();


func pause() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED;

func resume() -> void:
	process_mode = Node.PROCESS_MODE_INHERIT;
