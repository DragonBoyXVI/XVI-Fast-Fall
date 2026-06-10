extends Node


signal settings_changed();
func emit_settings_changed() -> void:
	settings_changed.emit();


const DISPLAY := "Display";
#region Display

## If true, the game window will always be scaled to the largest integer 
## amount hat fits within the current window size.[br]
## If false, the game window will always take up as much space as possible,
## with potential stretching issues.
var integer_scaling_enabled: bool = true;

## If above 0, force the game window to be that int scale, ignoring
## display window size.
var force_int_scale: int = 0;

#endregion Display
