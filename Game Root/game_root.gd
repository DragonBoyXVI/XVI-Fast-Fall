extends Node2D


var _current_game_room: Node2D;


func _ready() -> void:
	
	_change_room( "res://test_world.tscn" );


func _change_room( room_path: String ) -> void:
	assert( ResourceLoader.exists( room_path, "PackedScene" ) );
	
	#TODO fade screen here
	Radio.request_screen_hide();
	await Radio.screen_hidden;
	
	if ( _current_game_room ):
		_current_game_room.queue_free();
	
	var packed_scene: PackedScene = load( room_path );
	assert( packed_scene.can_instantiate() );
	
	_current_game_room = packed_scene.instantiate();
	add_child( _current_game_room );
	
	#TODO unfade screen here
	Radio.request_screen_show();
	await Radio.screen_shown;
