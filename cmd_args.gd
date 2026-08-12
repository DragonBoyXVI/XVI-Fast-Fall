@abstract
@tool
extends Object;
class_name CmdArgs;


const DEV_MODE := "--dev";


static var _args: PackedStringArray = [];


static func _static_init() -> void:
	
	_args = OS.get_cmdline_args();
	
	print( _args );
	print( OS.get_cmdline_user_args() );


static func has_arg( arg: String ) -> bool:
	return arg in _args;
