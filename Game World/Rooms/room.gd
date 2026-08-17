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
	
	#TEST
	var tracker := QuotaScore.new();
	add_child( tracker );
	Radio.quota_reached.connect( get_tree().quit, CONNECT_DEFERRED );
	Radio.quota_reached.connect( print.bind( "QUPTA" ) )


func pause() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED;

func resume() -> void:
	process_mode = Node.PROCESS_MODE_INHERIT;
