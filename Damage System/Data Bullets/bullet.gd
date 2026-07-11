@tool
@abstract
extends RefCounted;
#class_name Bullet;
## Base class for any kind of bullet.
##
## ditto


## Returns true if this bullet can be drawn.
## If this returns false once, it's removed from the draw loop.
@abstract func is_drawable() -> bool;

## Draw the bullet in the world
@abstract func draw( draw_node: Node2D ) -> void;

## Returns true of this node can be used in physics.
## If this returns false once, the bullet is removed from the loop.
@abstract func is_processable() -> bool;

## Do the bullet physics step
@abstract func process( world: World2D, delta: float ) -> void;
