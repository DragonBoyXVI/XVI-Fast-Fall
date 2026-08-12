extends Node2D


const _move_speed: float = 400.0;


@export var _health_node: HealthNode;

func _ready() -> void:
	pass

func _physics_process( delta: float ) -> void:
	_movement( delta, InputNames.get_move_dir() );
	
	if ( Input.is_action_pressed( InputNames.BACK ) ):
		var bullet := AreaBullet.new();
		bullet.damage_inst = DamageInst.new( 0 );
		bullet.transform.origin = get_global_mouse_position();
		Radio.fire_bullet( bullet );


func _movement( delta: float, dir: Vector2 ) -> void:
	
	var movement_offset: Vector2 = dir * delta * _move_speed;
	translate( movement_offset );
	position = position.clamp( Vector2.ZERO, Consts.SCREEN_SIZE );


func _on_hitbox_was_hit( dmg: DamageInst ) -> void:
	print( "ow! %s" % dmg.amount );
	_health_node.take_damage( dmg );

func _on_health_node_died() -> void:
	print( "Game Over!" );
	queue_free();
