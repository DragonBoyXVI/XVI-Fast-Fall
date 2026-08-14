@tool
extends PhysicsServerBullet;
class_name AreaBullet;
## A bullet that uses a physics area to detect [Hitbox] nodes.
##
## Should be much faster than using shape casts, as all this does is
## create a [PhysicsServer2D] area, configure it, then transform it every tick.


const PLAY_AREA: Rect2 = Rect2(
	Vector2.ONE * -64.0,
	Vector2( Consts.SCREEN_SIZE ) + ( Vector2.ONE * 64.0 )
);
const TEXTURE = preload( "res://XVI Assets/Images/Script Icons/state_node.atlastex" );


var _is_alive: bool = true;


## Radius of this bullets detection area
var radius: float = 8.0;

## How many pix/sec the bullet flies.
var speed: float = 400.0;

## How many [Hitbox]es this goes through before dying
var peirces: int = 0;


func initialize( world: World2D ) -> void:
	super( world );
	
	PhysicsServer2D.shape_set_data( _shape_rid, radius );

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
