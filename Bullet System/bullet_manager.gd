
extends Node2D;
class_name BulletManager;


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

func _physics_process( delta: float ) -> void:
	pass

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


func _init_bullet( bullet: Bullet ) -> void:
	
	var body_rid := PhysicsServer2D.area_create()
	bullet.body_rid = body_rid;
	PhysicsServer2D.area_set_collision_layer( body_rid, Consts.Collision.HITBOX );
	PhysicsServer2D.area_set_collision_mask( body_rid, Consts.Collision.NONE );
	PhysicsServer2D.area_add_shape( body_rid, _shape_rid );
	PhysicsServer2D.area_set_space( body_rid, get_world_2d().direct_space_state );
	
	PhysicsServer2D.area_set_monitorable( body_rid, false );
	PhysicsServer2D.area_set_area_monitor_callback( body_rid, _bullet_area_entered );
	
	var trans := Transform2D( bullet.direction, bullet.position );
	PhysicsServer2D.area_set_transform( body_rid, trans );

func _clean_bullet( bullet: Bullet ) -> void:
	
	PhysicsServer2D.free_rid( bullet.body_rid );


func _bullet_area_entered( status: PhysicsServer2D.AreaBodyStatus, area_rid: RID, instance_id: int, area_shape_index: int, self_shape_index: int ) -> void:
	if ( status == PhysicsServer2D.AREA_BODY_REMOVED ):
		return;
