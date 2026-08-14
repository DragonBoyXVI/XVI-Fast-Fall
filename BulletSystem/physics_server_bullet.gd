@tool
@abstract
extends Bullet;
class_name PhysicsServerBullet;
## A bullet class that makes and handles an area in the physics server
##
## Creates an area and shape rid in initianlize and frees them when this is deleted.
## be sure to call super() in initialize and notification else you break this class![br]
## this also gives you a monitor callback func already filled out to interact with the radio.


const CIRCLE_BASE_RADIUS := 8.0;


## Self managed area rid
var _area_rid: RID;
## Self managed shape rid
var _shape_rid: RID;


func _notification( what: int ) -> void:
	if ( what == NOTIFICATION_PREDELETE ):
		
		if ( _area_rid.is_valid() ):
			PhysicsServer2D.free_rid( _area_rid );
			_area_rid = RID();
		
		if ( _shape_rid.is_valid() ):
			PhysicsServer2D.free_rid( _shape_rid );
			_shape_rid = RID();


func initialize( world: World2D ) -> void:
	
	_shape_rid = PhysicsServer2D.circle_shape_create();
	PhysicsServer2D.shape_set_data( _shape_rid, CIRCLE_BASE_RADIUS );
	
	_area_rid = PhysicsServer2D.area_create();
	PhysicsServer2D.area_set_space( _area_rid, world.space );
	PhysicsServer2D.area_add_shape( _area_rid, _shape_rid );
	#PhysicsServer2D.area_set_monitorable( _area_rid, false );
	PhysicsServer2D.area_set_collision_layer( _area_rid, 0 );
	PhysicsServer2D.area_set_collision_mask( _area_rid, Hurtbox.collision_mask_from_team( team ) );
	PhysicsServer2D.area_set_area_monitor_callback( _area_rid, _on_area_monitor_callback );
	PhysicsServer2D.area_set_transform( _area_rid, transform );


func _on_area_monitor_callback( status: PhysicsServer2D.AreaBodyStatus, area_rid: RID, _instance_id: int, _area_shape_index: int, _self_shape_index: int ) -> void:
	
	if ( status == PhysicsServer2D.AREA_BODY_ADDED ):
		Radio.emit_bullet_hit_hitbox( area_rid, damage_inst );
