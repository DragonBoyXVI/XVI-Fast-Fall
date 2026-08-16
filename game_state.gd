@abstract
@tool
extends Object;
class_name GameState;


## If true, dev related drawing and tools are exposed.
static var dev_mode: bool = false;


static func _static_init() -> void:

	if ( Engine.is_editor_hint() ):
		return;

	dev_mode = CmdArgs.has_arg( CmdArgs.DEV_MODE );


## Counts how many things are being loaded
static var things_loading: int = 0;
