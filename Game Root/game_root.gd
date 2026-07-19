extends Node2D


@export var _room: Node2D;


const ASS := preload( "res://World/Enemies/Test Asteroid/test_asteroid.tscn" );


func _ready() -> void:
	
	Radio.room_change_requested.connect( _on_radio_room_change_requested, CONNECT_DEFERRED );
	
	
	for i: int in ( randi() % 11 ) + 15:
		await get_tree().create_timer( randf() * 2 ).timeout;
		
		add_child( ASS.instantiate() );


func _change_room( room_path: String ) -> void:
	
	# if scree is still fading in, wait for it
	if ( GameState.screen_fade_state < GameState.ScreenFadeState.HIDDEN ):
		await Radio.screen_faded;
	
	var room_scene: PackedScene = load( room_path );
	assert( room_scene and room_scene.can_instantiate() );
	var room_node: Node2D = room_scene.instantiate();
	if ( _room ):
		_room.queue_free();
	_room = room_node;
	add_child.call_deferred( _room );
	
	Radio.emit_room_changed();


func _on_radio_room_change_requested( room_path: String ) -> void:
	_change_room( room_path );
