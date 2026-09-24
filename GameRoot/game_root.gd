extends Node2D;


const DEFAULT_SCREEN_COVER_PATH := "uid://cupsm6cx3cwq2";


@export var _screen_covers_root: Control;
## used to hide any visual burps from changing the cover scene.
@export var _true_screen_cover: Control;
## used to play screen un/cover animations
var _screen_cover: ObjScreenCover;


func _ready() -> void:
	
	if ( Engine.is_editor_hint() ):
		return;
	
	var loaded_cover: PackedScene = load( DEFAULT_SCREEN_COVER_PATH );
	_screen_cover = loaded_cover.instantiate();
	_screen_covers_root.add_child( _screen_cover );
