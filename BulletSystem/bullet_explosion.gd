@tool
extends PhysicsServerBullet;
class_name ExplosionBullet;
## An explosion that hurts everything in an area, then disapears.
##
## aos-a


const FADE_OUT_TIME := 2.0;


## The largest radius this explosion will reach
var max_radius: float = 256.0;
## How quickly this explosions radius grows in pix/sec.
var radius_growth: float = 4000.0


var _current_radius: float = 1.0;
var _die_time: float = 0.0;


var _is_dead: bool = false;
var _is_growing: bool = true;


func initialize( world: World2D ) -> void:
	super( world );
	
	PhysicsServer2D.shape_set_data( _shape_rid, _current_radius );

func is_drawable() -> bool:
	return _die_time < FADE_OUT_TIME;

func draw( draw_node: Node2D ) -> void:
	const FUll_COLOR := Hurtbox.SHAPE_COLOR;
	const FADE_COLOR := Color( FUll_COLOR, 0.0 );
	
	var color: Color = FUll_COLOR.lerp( FADE_COLOR, _die_time / FADE_OUT_TIME );
	draw_node.draw_circle( transform.origin, _current_radius, color );

func is_physics_processable() -> bool:
	return not _is_dead;

func physics_process( delta: float, _world: World2D ) -> void:
	
	if ( _is_growing ):
		
		_current_radius = minf( _current_radius + ( radius_growth * delta ), max_radius );
		PhysicsServer2D.shape_set_data( _shape_rid, _current_radius );
		
		if ( _current_radius >= max_radius ):
			_is_growing = false;
	else:
		_die_time += delta;


func _on_area_monitor_callback( status: PhysicsServer2D.AreaBodyStatus, area_rid: RID, _instance_id: int, _area_shape_index: int, _self_shape_index: int ) -> void:
	if ( _is_growing ):
		super( status, area_rid, _instance_id, _area_shape_index, _self_shape_index );
