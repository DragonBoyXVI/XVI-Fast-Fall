@tool
extends Room;
class_name GameRoom;
## A room where a round of play occurs.
##
## Spawns a player and a quota


const PLAYER_SCENE: PackedScene = preload( "uid://pqntxoy6xkil" );


var _player: Node2D;


func _ready() -> void:
	super();
	
	if ( Engine.is_editor_hint() ):
		return;
	
	_player = PLAYER_SCENE.instantiate();
	add_child( _player );
