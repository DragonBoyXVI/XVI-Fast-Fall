extends Node2D


@export var _current_game_room: Node2D;


const FILE_MAIN_MENU := "uid://bbvv23ucu3s2y";
const FILE_GAMEMODE_SELECT := "uid://c0f3genbtarw7";


func _ready() -> void:
	
	_change_room( FILE_MAIN_MENU );
	
	Radio.game_start_pressed.connect( _on_radio_game_start_pressed );


func _change_room( room_path: String ) -> void:
	assert( ResourceLoader.exists( room_path, "PackedScene" ) );
	
	Radio.request_screen_hide();
	await Radio.screen_hidden;
	
	if ( _current_game_room ):
		_current_game_room.queue_free();
	
	var packed_scene: PackedScene = load( room_path );
	assert( packed_scene.can_instantiate() );
	
	_current_game_room = packed_scene.instantiate();
	add_child( _current_game_room );
	
	Radio.request_screen_show();
	await Radio.screen_shown;


func _on_radio_game_start_pressed() -> void:
	_change_room( FILE_GAMEMODE_SELECT );
