@tool
extends Node2D;


@export_group( "Components" )
@export var _health_node: HealthNode2D;
@export var _hitbox: Hitbox2D;
@export var _movement_node: MovementComponent;



func _ready() -> void:
	
	if ( Engine.is_editor_hint() ):
		XVIFuncs.set_node_processes( self, false );
		return;
	
	_health_node.died.connect( _on_health_node_died );
	
	_hitbox.took_damage.connect( _on_hitbox_took_damage );

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


func _on_health_node_died() -> void:
	
	print( "you died!!!" );
	queue_free();

func _on_hitbox_took_damage( damage_inst: DamageInst ) -> void:
	_health_node.damage( damage_inst );
	print( _health_node.get_current_hp() );
