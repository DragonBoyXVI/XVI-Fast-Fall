extends Control;
class_name ScreenFaderManager;


signal fade_done();


@export_file( "*.tscn", "*.scn" ) var _default_fader_path: String = "";


var _is_fader_ready: bool = false;
var _current_fader: ScreenFader;
# String compairision so we dont load an already loaded fader.
var _current_fader_path: String = "";


func _ready() -> void:
	load_fader_threaded( _default_fader_path );
	hide();


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
	
	if ( _current_fader ):
		_current_fader.queue_free();
	_current_fader = fader_node;
	add_child( _current_fader );

	_is_fader_ready = true;


func fade_in() -> void:
	show();
	_current_fader.play_anim( ScreenFader.ANIM_IN );
	await _current_fader.anim_done;
	fade_done.emit();

func fade_out() -> void:
	_current_fader.play_anim( ScreenFader.ANIM_OUT );
	await _current_fader.anim_done;
	fade_done.emit();
	hide();
