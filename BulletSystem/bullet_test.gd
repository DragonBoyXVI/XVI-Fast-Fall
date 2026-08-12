@tool
extends Bullet;
class_name BulletTest;


const TEXTURE = preload( "res://XVI Assets/Images/Script Icons/state_node.atlastex" );


var _draw_area: Rect2;

var _speed := randf_range( 400.0, 800.0 ) * 0.25;


func initialize( _world: World2D ) -> void:
	_draw_area = Rect2(
		TEXTURE.get_size(),
		Vector2( Consts.SCREEN_SIZE ) + TEXTURE.get_size()
	);
	
	transform = transform.rotated_local( randf() * TAU );

func is_drawable() -> bool:
	return is_physics_processable();

func draw( draw_node: Node2D ) -> void:
	draw_node.draw_set_transform_matrix( transform );
	draw_node.draw_texture( TEXTURE, TEXTURE.get_size() * -0.5 );
	draw_node.draw_set_transform_matrix( Transform2D.IDENTITY );

func is_physics_processable() -> bool:
	return _draw_area.has_point( transform.origin );

func physics_process( delta: float, _world: World2D ) -> void:
	transform.origin += transform.x * delta * _speed;
