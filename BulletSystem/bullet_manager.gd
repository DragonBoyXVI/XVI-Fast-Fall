extends Node2D;
class_name BulletManager;
## Handles bullets fired in this space
##
## shooto


static func get_tick_split_for_bullet_count( count: int ) -> int:
	var tick_split := ceili( count * 0.01 );
	return maxi( 1, tick_split );


var _active_physics_bullets: Array[ Bullet ] = [];
var _remove_physics_bullets: Array[ Bullet ] = [];
var _active_draw_bullets: Array[ Bullet ] = [];
var _remove_draw_bullets: Array[ Bullet ] = [];

# draw an extra time to ensure that draw state is clear
var _extra_draw: bool = false;

var _tick_offset: int = 0;


func _ready() -> void:
	
	Radio.bullet_fired.connect( _on_radio_bullet_fired, CONNECT_DEFERRED );

func _process( delta: float ) -> void:
	
	if ( not _remove_draw_bullets.is_empty() ):
		for bullet: Bullet in _remove_draw_bullets:
			_active_draw_bullets.erase( bullet );
		_remove_draw_bullets.clear();
	
	if ( _extra_draw or not _active_draw_bullets.is_empty() ):
		_extra_draw = not _active_draw_bullets.is_empty();
		queue_redraw();
		
		for bullet: Bullet in _active_draw_bullets:
			bullet.draw_time += delta;
			if ( not bullet.is_drawable() ):
				_remove_draw_bullets.append( bullet );

func _physics_process( delta: float ) -> void:
	
	if ( not _remove_physics_bullets.is_empty() ):
		for bullet: Bullet in _remove_physics_bullets:
			_active_physics_bullets.erase( bullet );
		_remove_physics_bullets.clear();
	
	if ( _active_physics_bullets.is_empty() ):
		return;
		
	var tick_split: int = get_tick_split_for_bullet_count( _active_physics_bullets.size() );
	delta *= tick_split;
	
	for bullet_index in _active_physics_bullets.size():
		if ( ( bullet_index + _tick_offset ) % tick_split != 0 ):
			continue;
		
		var bullet: Bullet = _active_physics_bullets[ bullet_index ];
		if ( bullet.is_physics_processable() ):
			bullet.physics_process( delta, get_world_2d() );
		else:
			_remove_physics_bullets.append( bullet );
	
	_tick_offset += 1;

func _draw() -> void:
	draw_string( ThemeDB.fallback_font, Vector2( 16.0, 64.0 ), str( _active_physics_bullets.size() ) );
	if ( _active_draw_bullets.is_empty() ):
		return;
	
	for bullet: Bullet in _active_draw_bullets:
		bullet.draw( self );


func _on_radio_bullet_fired( bullet: Bullet ) -> void:
	
	bullet.initialize( get_world_2d() );
	_active_physics_bullets.append( bullet );
	_active_draw_bullets.append( bullet );
