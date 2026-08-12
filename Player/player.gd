extends Node2D


const STATE_FREE := &"PlayerFree";
const STATE_DASH := &"PlayerDash";


@export_group( "Comps" )
@export var _health_node: HealthNode;


func _ready() -> void:
	pass


func routine_movement( delta: float, dir: Vector2, speed: float ) -> void:
	
	var movement_offset: Vector2 = dir * delta * speed;
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
