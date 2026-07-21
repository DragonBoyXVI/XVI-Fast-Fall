extends Control;
class_name FadeManager;


const DEFAULT_FADER: PackedScene = preload("uid://5q3tqy7saw7d");


var _fader_scene: Control;


func  _ready() -> void:
	
	_fader_scene = DEFAULT_FADER.instantiate();
	add_child( _fader_scene );


func _change_fader( fader_path: String ) -> void:
	assert( ResourceLoader.exists( fader_path, "PackedScene" ) );
	
	if ( _fader_scene ):
		_fader_scene.queue_free();
	
	var packed_scene: PackedScene = load( fader_path );
	assert( packed_scene.can_instantiate() );
	
	_fader_scene = packed_scene.instantiate();
	add_child( _fader_scene );
