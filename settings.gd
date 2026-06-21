@abstract
@tool
extends Object;
class_name Settings;


const DEFAULT_FILE_PATH := "user://settings.config"


const DISPLAY := "Display";
#region Display

## If true, the game window will always be scaled to the largest integer 
## amount hat fits within the current window size.[br]
## If false, the game window will always take up as much space as possible,
## with potential stretching issues.
static var integer_scaling_enabled: bool = false;

## If above 0, force the game window to be that int scale, ignoring
## display window size.
static var force_int_scale: int = -1;

#endregion Display


static func _static_init() -> void:
	
	if ( Engine.is_editor_hint() ):
		return;
	
	if ( FileAccess.file_exists( DEFAULT_FILE_PATH ) ):
		load_file();


## Saves settings to a config file
static func save_to_file( path: String = DEFAULT_FILE_PATH ) -> void:
	assert( path.is_valid_filename(), "Not a valid file!" );
	
	var config_file := ConfigFile.new();
	
	#region Display
	
	config_file.set_value( DISPLAY, "integer_scaling_enabled", integer_scaling_enabled );
	config_file.set_value( DISPLAY, "force_int_scale", force_int_scale );
	
	#endregion Display
	
	config_file.save( path );

static func load_file( path: String = DEFAULT_FILE_PATH ) -> void:
	
	var config_file := ConfigFile.new();
	var err := config_file.load( path );
	
	assert( err == OK, error_string( err ) );
	
	#region Display
	
	integer_scaling_enabled = config_file.get_value( DISPLAY, "integer_scaling_enabled", integer_scaling_enabled );
	force_int_scale = config_file.get_value( DISPLAY, "force_int_scale", force_int_scale );
	
	#endregion Display
