@abstract
extends RefCounted;
class_name Bullet;
## Base class for bullets.
##
## dogagedi


enum Target {
	PLAYER = 1,
	ENEMY = 2,
	
	ALL = PLAYER | ENEMY,
}

var target: Target = Target.ALL;

## Transform for global coords and rotation
var transform := Transform2D.IDENTITY;

## How long this has been in the physics loop
var physics_time: float = 0.0;
## How long this has been in the draw loop.
var draw_time: float = 0.0;

var damage: Damage = Damage.new( 1 );
var owner: Node;


## Returns false when this bullet is no longer active in physics.
@abstract func is_processable() -> bool;

## The bullets physics process
@abstract func process( world: World2D, delta: float ) -> void;

## Returns false when the bullet is no longer visible.
@abstract func is_drawable() -> bool;

## Draws the node on the screen.
@abstract func draw( draw_node: Node2D ) -> void;
