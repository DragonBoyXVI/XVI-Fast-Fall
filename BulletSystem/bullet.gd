@tool
@abstract
extends RefCounted;
class_name Bullet;
## A bare bones bullet template.
## holds info like the [DamageInst] and transform.
##
## When you create any subclass of this, dont keep the refrence outside of
## the needed scope.

## The damage this bullet will do.
var damage_inst: DamageInst;

## The position and rotation of this bullet.
## Scale too but idk if thats gonna be used
var transform: Transform2D = Transform2D.IDENTITY;

## The team this belongs to
var team: Consts.Team = Consts.Team.NONE;


## Time spent inside the draw loop.
var draw_time: float = 0.0;
## Time spent in the physics loop.
var physics_time: float = 0.0;


## Inits some data for this.
@abstract func initialize() -> void;

## Return true if this can be drawn
@abstract func is_drawable() -> bool;

## Draw this to the screen
@abstract func draw( draw_node: Node2D ) -> void;

## Return true if this is usable in the physics loop
@abstract func is_physics_processable() -> bool;

## Process this on the physics side
@abstract func physics_process( delta: float, world: World2D ) -> void;
