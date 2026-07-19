@abstract
@tool
extends Object;
class_name CmdArgs;
## Info related to command line arguments
##
## provide the game arguments to change it


static var _args: PackedStringArray = [];


static func _static_init() -> void:
	
	_args = OS.get_cmdline_args();
	print( "CMD args: ", _args );


## If this returns true, the game has been provided with this argument.
static func has_arg( arg: String ) -> bool:
	return arg in _args;


## Command line to activate developer mode.
const DEV_MODE := "--dev";
