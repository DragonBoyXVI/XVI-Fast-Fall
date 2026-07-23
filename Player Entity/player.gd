@tool
extends Node2D


enum MyStates {
	FREE,
	DASHING,
	
	CUTSCENE,
}


@export var _speed: float = 400.0;


var _state: MyStates = MyStates.FREE;


## When dashing youll always move in the direction you last moved in.
var _last_moved_dir: Vector2 = Vector2.DOWN;


func _ready() -> void:
	
	if ( Engine.is_editor_hint() ):
		
		XVIFuncs.set_node_processes( self, false );
		return;

func _physics_process( delta: float ) -> void:
	if ( _state == MyStates.CUTSCENE ): return;
	
	_routine_movement( delta, InputNames.get_move_dir() );


func _routine_movement( delta: float, direction: Vector2 ) -> void:
	if ( not direction.is_zero_approx() ):
		_last_moved_dir = direction.normalized();
	
	var velocity: Vector2 = direction;
	if ( _state == MyStates.DASHING ):
		velocity = _last_moved_dir * 2.0;
	velocity *= _speed * delta;
	
	var new_pos := position + velocity;
	position = new_pos.clamp( Vector2.ZERO, Consts.SCREEN_SIZE );
