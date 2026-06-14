#@tool
extends Node2D;
class_name TestAsteroid;


const _SPEED = 200;


@export var _hitbox: Hitbox;
@export var _hurtbox: Hurtbox;


func _ready() -> void:
	
	if ( Engine.is_editor_hint() ):
		
		XVIFuncs.disable_node_processes( self );
		return;
	
	global_position.y = Consts.SCREEN_SIZE.y;
	global_position.x = Consts.SCREEN_SIZE.x * randf();
	
	_hitbox.took_damage.connect( _on_hitbox_took_damage );
	_hurtbox.hitbox_entered.connect( _on_hurtbox_hitbox_entered );

func _physics_process( delta: float ) -> void:
	
	if ( position.y < 0.0 ):
		queue_free();
		return;
	
	var move_dist: float = _SPEED * delta;
	position.y -= move_dist;


func _on_hitbox_took_damage( _dmg: Damage ) -> void:
	queue_free();

func _on_hurtbox_hitbox_entered( hitbox: Hitbox ) -> void:
	hitbox.take_damage( Damage.new( 1 ) );
