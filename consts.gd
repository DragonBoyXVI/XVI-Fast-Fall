@abstract
@tool
extends Object;
class_name Consts;


static func _static_init() -> void:
	_editor_layer_names();


## Smallest size of the game display viewport.
## Also the size of the play area ingame.
const SCREEN_SIZE: Vector2i = Vector2i(
	480,
	720
);

enum Menu {
	PAUSE,
}

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
	
	PLAYER_HITBOX = 1<<0,
	ENEMY_HITBOX = 1<<1,
	
}
static func _editor_layer_names() -> void:
	
	const PATH := "layer_names/2d_physics/layer_%s";
	ProjectSettings.set_setting( PATH % 1, "Player Hitbox" );
	ProjectSettings.set_setting( PATH % 2, "Enemy Hitbox" );

enum Team {
	NONE = 0,
	
	PLAYER = 1<<0,
	ENEMY = 1<<1,
	
	ALL = 0b11,
}
