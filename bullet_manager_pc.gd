@tool
extends Node2D;
class_name BulletManager;



var _physics_bullets: Array[ Bullet ] = [];
var _physics_remove: Array[ Bullet ] = [];
var _draw_bullets: Array[ Bullet ] = [];
var _draw_remove: Array[ Bullet ] = [];

var _extra_draw: bool = false;


func _ready() -> void:
	
	if ( Engine.is_editor_hint() ):
		XVIFuncs.set_node_processes( self, false );
		return;
	
	Radio.bullet_fired.connect( _on_radio_bullet_fired, CONNECT_DEFERRED );

func _validate_property( property: Dictionary ) -> void:
	FFFuncs.disable_prop_2ds( property );

func _process( delta: float ) -> void:
	
	for bullet in _draw_remove:
		_draw_bullets.erase( bullet );
	
	if ( _extra_draw or !_draw_bullets.is_empty() ):
		_extra_draw = not _draw_bullets.is_empty();
		
		for bullet in _draw_bullets:
			if ( bullet.is_drawable() ):
				bullet.draw_time += delta;
			else:
				_draw_remove.append( bullet );
		
		queue_redraw();

func _physics_process( delta: float ) -> void:
	
	for bullet in _physics_remove:
		_physics_bullets.erase( bullet );
	
	var world := get_world_2d();
	for bullet in _physics_bullets:
		
		if ( not bullet.is_processable() ):
			_physics_remove.append( bullet );
		
		bullet.physics_time += delta;
		bullet.process( world, delta );

func  _draw() -> void:
	
	for bullet in _draw_bullets:
		bullet.draw( self );


func _on_radio_bullet_fired( bullet: Bullet ) -> void:
	
	_physics_bullets.append( bullet );
	_draw_bullets.append( bullet );
