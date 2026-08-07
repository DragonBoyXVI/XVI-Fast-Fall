@tool
extends Node2D;
class_name AnimationModel2D;


## When told to play an animation, this will send that
## request to all of these nodes.
#@export var _players: Array[ AnimationPlayer ] = [];

## The animation player this uses
@export var _animation_player: AnimationPlayer;
