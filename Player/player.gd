extends Node2D


const _move_speed: float = 400.0;


@export var _health_node: HealthNode;
@export var _shooter_node: ShooterNode;


func _ready() -> void:
	pass

func _physics_process( delta: float ) -> void:
	_movement( delta, InputNames.get_move_dir() );
	
	_shooter_node.trigger_held = Input.is_action_pressed( InputNames.ENTER );


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

func _on_shooter_node_shot_fired( bullet_transform: Transform2D ) -> void:
	
	var bullet := AreaBullet.new();
	bullet.transform = bullet_transform;
	bullet.team = Consts.Team.PLAYER;
	bullet.damage_inst = DamageInst.new( 1 );
	
	Radio.fire_bullet( bullet );
