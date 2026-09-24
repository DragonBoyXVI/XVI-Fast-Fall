@abstract
@tool
extends State;
class_name PlayerState;


@export var _player: ObjPlayer:
	set( new ):
		_player = new;
		update_configuration_warnings();


func _get_configuration_warnings() -> PackedStringArray:
	var warnings := PackedStringArray();
	
	if ( _player == null ):
		warnings.append( "Please assign the player to this!" );
	
	return warnings;
