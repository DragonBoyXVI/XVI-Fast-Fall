@tool
extends Bullet;
class_name AreaBullet;


const PLAY_AREA: Rect2 = Rect2(
	Vector2.ONE * -64.0,
	Vector2( Consts.SCREEN_SIZE ) + ( Vector2.ONE * 64.0 )
);
const TEXTURE = preload( "res://XVI Assets/Images/Script Icons/state_node.atlastex" );


var _area_rid: RID;
var _shape_rid: RID;

var _is_alive: bool = true;


## Radius of this bullets detection area
var radius: float = 8.0;

## How many pix/sec the bullet flies.
var speed: float = 400.0;

## How many [Hitbox]es this goes through before dying
var peirces: int = 0;


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
	PhysicsServer2D.shape_set_data( _shape_rid, radius );
	
	_area_rid = PhysicsServer2D.area_create();
	PhysicsServer2D.area_set_space( _area_rid, world.space );
	PhysicsServer2D.area_add_shape( _area_rid, _shape_rid );
	#PhysicsServer2D.area_set_monitorable( _area_rid, false );
	PhysicsServer2D.area_set_collision_layer( _area_rid, 0 );
	PhysicsServer2D.area_set_collision_mask( _area_rid, Hurtbox.collision_mask_from_team( team ) );
	PhysicsServer2D.area_set_area_monitor_callback( _area_rid, _on_area_monitor_callback );
	PhysicsServer2D.area_set_transform( _area_rid, transform );

func is_drawable() -> bool:
	return PLAY_AREA.has_point( transform.origin ) and _is_alive;

func draw( draw_node: Node2D ) -> void:
	draw_node.draw_set_transform_matrix( transform );
	
	var offset: Vector2 = TEXTURE.get_size() * -0.5;
	draw_node.draw_texture( TEXTURE, offset );
	
	if ( GameState.dev_mode ):
		draw_node.draw_circle( Vector2.ZERO, radius, Hurtbox.SHAPE_COLOR );
	
	draw_node.draw_set_transform_matrix( Transform2D.IDENTITY );

func is_physics_processable() -> bool:
	return is_drawable();

func physics_process( delta: float, _world: World2D ) -> void:
	
	transform.origin += transform.x * delta * speed;
	PhysicsServer2D.area_set_transform( _area_rid, transform );


func _on_area_monitor_callback( status: PhysicsServer2D.AreaBodyStatus, area_rid: RID, _instance_id: int, _area_shape_index: int, _self_shape_index: int ) -> void:
	
	if ( status == PhysicsServer2D.AREA_BODY_ADDED ):
		Radio.emit_bullet_hit_hitbox( area_rid, damage_inst );
		
		peirces -= 1;
		if ( peirces < 0 ):
			_is_alive = false;
