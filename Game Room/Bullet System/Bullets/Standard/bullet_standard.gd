
extends Bullet;
class_name BulletStandard;


const _PLAY_AREA := Rect2( Vector2.ZERO, Vector2( Consts.SCREEN_SIZE ) );


const _shape_med: CircleShape2D = preload( "uid://bgyea2lodxcd4" );


var texture: Texture2D = preload( "res://addons/xvi_utilities/Assets/Script Icons/state_machine_node.atlastex" );
var speed = 200;
var shape = _shape_med:
	get: return shape.duplicate() if shape else null;

var max_collisions: int = 1;


var _collision_count: int = 0;

var _first_process: bool = true;
var _collision_mask: int = 0;

var _first_draw: bool = true;
var _texture_offset := Vector2.ZERO;
var _texture_color := Color.WHITE;


func is_processable() -> bool:
	
	if ( not _PLAY_AREA.has_point( transform.origin ) ):
		return false;
	
	return _collision_count < max_collisions;

func process( world: World2D, delta: float ) -> void:
	
	if ( _first_process ):
		_first_process = false;
		
		if ( target & Target.PLAYER ):
			_collision_mask |= Consts.Collision.PLAYER_HITBOX;
		if ( target & Target.ENEMY ):
			_collision_mask |= Consts.Collision.ENEMY_HITBOX;
	
	var query := PhysicsShapeQueryParameters2D.new();
	query.collide_with_areas = true;
	query.collide_with_bodies = false;
	query.collision_mask = _collision_mask;
	query.motion = transform.origin + ( transform.x * speed * delta );
	query.shape = shape;
	
	const COLLIDER := "collider";
	var results: Array[ Dictionary ] = world.direct_space_state.intersect_shape( query );
	for result: Dictionary in results:
		if ( _collision_count >= max_collisions ):
			break;
		
		if result[ COLLIDER ] is not Hitbox:
			continue;
		
		var hitbox: Hitbox = result[ COLLIDER ];
		hitbox.take_damage( damage );
		_collision_count += 1;
	
	transform.origin += transform.x * speed * delta;

func is_drawable() -> bool:
	return is_processable();

func draw( draw_node: Node2D ) -> void:
	
	if ( _first_draw ):
		_first_draw = false;
		
		_texture_offset = texture.get_size() * 0.5;
		
		if ( target & Target.PLAYER ):
			_texture_color = Color.RED;
		else:
			_texture_color = Color.BLUE;
	
	draw_node.draw_set_transform_matrix( transform );
	draw_node.draw_texture( texture, -_texture_offset, _texture_color );
	draw_node.draw_set_transform_matrix( Transform2D.IDENTITY );
