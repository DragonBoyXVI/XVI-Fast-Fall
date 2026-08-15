extends Control;
class_name ScreenFaderManager;


@export_file( "*.tscn", "*.scn" ) var _default_fader_path: String = "";


var _is_fader_ready: bool = false;
var _current_fader: Control;
# String compairision so we dont load an already loaded fader.
var _current_fader_path: String = "";


func _ready() -> void:
	load_fader_threaded( _default_fader_path );


## Loads and sets the current fader to this.
func load_fader_threaded( fader_path: String ) -> void:
	
	if ( _current_fader_path == fader_path ):
		push_warning( "Trying to load an already loaded fader" )
		return;
	
	_is_fader_ready = false;
	
	var fader_scene: PackedScene = await XVIFuncs.load_resource_coroutine(
		fader_path, "PackedScene"
	);
	assert( fader_scene.can_instantiate() );
	var fader_node: Control = fader_scene.instantiate();
	
	_current_fader.queue_free();
	_current_fader = fader_node;

	_is_fader_ready = true;
