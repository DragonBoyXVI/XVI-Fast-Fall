extends Node2D


@export var _current_room: Node2D;
@export var _screen_fade_manager: ScreenFaderManager;


func _ready() -> void:

	var time := get_tree().create_timer( 2.0 );
	time.timeout.connect( print.bind( "DONW" ) );
	await time.timeout;
	change_room( "res://test_world.tscn" );


func change_room( room_path: String ) -> void:

	# pause current room?
	
	await _screen_fade_manager.fade_in();
	
	var room_scene: PackedScene = await XVIFuncs.load_resource_coroutine( room_path, "PackedScene" );
	assert( room_scene.can_instantiate() );
	if ( _current_room ):
		_current_room.queue_free();
	_current_room = room_scene.instantiate();
	add_child( _current_room );

	# pause room again?
	# does room auto pause?
	
	await _screen_fade_manager.fade_out();
	
	# unpause room
	
	pass
