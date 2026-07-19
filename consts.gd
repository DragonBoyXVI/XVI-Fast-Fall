@abstract
@tool
extends Object;
class_name Consts;


static func _static_init() -> void:
	print( "Consts initialized!" );
	
	_editor_layer_names();


## Smallest size of the game display viewport.
## Also the size of the play area ingame.
const SCREEN_SIZE: Vector2i = Vector2i(
	480,
	720
);

## Visual layers for objects to draw on.
enum ZLayers {
	BACKGROUNDS = 0,
	
	BOSSES = 3,
	ENEMIES = 4,
	PLAYER = 5,
	
	BULLETS = 6,
}

## Godot collision layers
enum Collision {
	
	ENTITY_WALLS = 1<<0,
	BULLET_WALLS = 1<<1,
	
	HITBOX = 1<<2,
	
}
static func _editor_layer_names() -> void:
	
	const PATH := "layer_names/2d_physics/layer_%s";
	ProjectSettings.set_setting( PATH % 1, "Entity Walls" );
	ProjectSettings.set_setting( PATH % 2, "Bullet Walls" );
	
	ProjectSettings.set_setting( PATH % 3, "Hitboxes" );

enum Team {
	NONE = 0,
	
	PLAYER = 1<<0,
	ENEMY = 1<<1,
	
	ALL = 0b11,
}
