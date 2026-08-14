extends Node2D


const STATE_FREE := &"PlayerFree";
const STATE_DASH := &"PlayerDash";


@export_group( "Comps" )
@export var _health_node: HealthNode;
@export var _state_machine: StateMachine


func routine_movement( delta: float, dir: Vector2, speed: float ) -> void:
	
	var movement_offset: Vector2 = dir * delta * speed;
	translate( movement_offset );
	position = position.clamp( Vector2.ZERO, Consts.SCREEN_SIZE );


func _on_hitbox_was_hit( dmg: DamageInst ) -> void:
	
	print( "ow! %s" % dmg.amount );
	_health_node.take_damage( dmg );

func _on_health_node_died() -> void:
	print( "Game Over!" );
	_state_machine.set_deferred( &"process_mode", PROCESS_MODE_DISABLED );
	
	Engine.time_scale = 0.01;
	var time_tween := get_tree().create_tween();
	time_tween.set_ease( Tween.EASE_IN );
	#time_tween.set_trans( Tween.TRANS_EXPO );
	time_tween.set_pause_mode( Tween.TWEEN_PAUSE_PROCESS );
	time_tween.tween_property( Engine, ^"time_scale", 1.0, 1.0 );
	
	var tween := create_tween();
	tween.tween_property( self, ^"modulate", Color.TRANSPARENT, 2.0 );
	
	Radio.emit_player_died();
	await tween.finished;
	Radio.request_open_menu( Consts.Menu.GAME_OVER );
	queue_free();

func _on_shooter_node_shot_fired( bullet_transform: Transform2D ) -> void:
	
	var bullet := AreaBullet.new();
	bullet.transform = bullet_transform;
	bullet.team = Consts.Team.PLAYER;
	bullet.damage_inst = DamageInst.new( 1 );
	
	Radio.fire_bullet( bullet );
