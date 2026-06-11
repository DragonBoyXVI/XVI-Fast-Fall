@abstract
@tool
extends Object;
class_name Consts;


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
