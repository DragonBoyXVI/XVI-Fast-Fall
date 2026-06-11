@abstract
@tool
extends Object;
class_name FFFuncs;
## Class that stores helper functions.
##
## helpo =3


## Some properties i like to disable on 2d node classes
static func disable_prop_2ds( property: Dictionary ) -> void:
	const DISABLED: PackedStringArray = [
		"position",
		"rotation",
		"scale",
		"skew",
		"z_index",
		"z_as_relative",
		"y_sort_enabled",
	];
	
	if ( property[ Property.NAME ] in DISABLED ):
		property[ Property.USAGE ] = PROPERTY_USAGE_NONE;
