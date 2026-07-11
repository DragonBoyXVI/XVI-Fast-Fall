@tool
extends Node2D;


@export_group( "Components" )
@export var _health_node: HealthNode2D;
@export var _movement_node: PlayerMovement;



func _ready() -> void:
	
	if ( Engine.is_editor_hint() ):
		XVIFuncs.set_node_processes( self, false );
		return;
	pass

func _physics_process( delta: float ) -> void:
	
	_movement_node.move( delta, InputNames.get_move_dir() );

func _unhandled_input( event: InputEvent ) -> void:
	if ( event.is_echo() ): return;
	if ( event.is_canceled() ): return;
	
	if ( event.is_action_pressed( InputNames.BACK ) ):
		
		print( "ran")
		_movement_node.dash();
		
		get_window().set_input_as_handled();
		return;
