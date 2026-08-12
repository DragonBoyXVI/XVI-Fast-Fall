@tool
@abstract
extends State;
class_name PlayerState;


const Player: Script = preload( "uid://cv3651o2h7na3" );


@export var _player: Player:
	set( new ):
		_player = new;
		update_configuration_warnings();


func _ready() -> void:
	
	if ( Engine.is_editor_hint() ):
		XVIFuncs.set_node_processes( self, false );
		return;

func _get_configuration_warnings() -> PackedStringArray:
	var warnings := PackedStringArray();
	
	if ( not _player ):
		warnings.append( "This needs the player node!" );
	
	return warnings;
