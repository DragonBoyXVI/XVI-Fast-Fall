
extends Node2D;
class_name BulletManager;


class Bullet:
	extends RefCounted;
	
	var owner: Node2D;
	var body_rid: RID;
	
	var position: Vector2;
	var direction: float;
	var speed: float;
	
	var team: Consts.Team;


const BULLET_RADIUS := 16.0;


var _shape_rid: RID;
var _active_bullets: Array[ Bullet ] = [];
var _destroy_bullets: Array[ Bullet ] = [];

var _extra_draw: bool = false;


func _enter_tree() -> void:
	
	_shape_rid = PhysicsServer2D.circle_shape_create();
	PhysicsServer2D.shape_set_data( _shape_rid, BULLET_RADIUS );

func _exit_tree() -> void:
	
	PhysicsServer2D.free_rid( _shape_rid );

func _process( _delta: float ) -> void:
	if ( _extra_draw or not _active_bullets.is_empty() ):
		_extra_draw = not _active_bullets.is_empty();
		queue_redraw();

func _draw() -> void:
	if ( _active_bullets.is_empty() ): return;
	
	const TEXTURE: Texture2D = preload( "res://icon.svg" );
	const TEXTURE_SIZE: Vector2 = Vector2.ONE * 0.5;
	var texture_offset: Vector2 = TEXTURE.get_size() * TEXTURE_SIZE * 0.5;
	
	for bullet: Bullet in _active_bullets:
		draw_set_transform( bullet.position, bullet.direction, TEXTURE_SIZE );
		
		var color := Color.RED;
		if ( bullet.team == Consts.Team.PLAYER ):
			color = Color.BLUE;
		draw_texture( TEXTURE, texture_offset, color );
		
		draw_set_transform_matrix( Transform2D.IDENTITY );


func _remove_bullet( bullet: Bullet ) -> void:
	pass
