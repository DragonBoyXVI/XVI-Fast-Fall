@tool
extends PlayerState;


## How fast you move in pix/sec.
@export var _speed: float = 400.0;

@export var _shooter_node: ShooterNode;


func _physics_process( delta: float ) -> void:
	
	_player.routine_movement( delta, InputNames.get_move_dir(), _speed );
	_shooter_node.trigger_held = Input.is_action_pressed( InputNames.ENTER );

func _unhandled_input( event: InputEvent ) -> void:
	if ( event.is_echo() ): return;
	if ( event is InputEventMouseMotion ): return;
	
	if ( event.is_action_pressed( InputNames.BACK ) ):
		
		emit_state_change_request( Player.STATE_DASH );
		
		get_window().set_input_as_handled();
		return;


func _leave_state() -> void:
	_shooter_node.trigger_held = false;
