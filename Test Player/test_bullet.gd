extends Sprite2D


const SPEED := Vector2( 0.0, 600.0 );


func _physics_process( delta: float ) -> void:
	translate( SPEED * delta );
	
	if ( not Consts.PLAY_AREA.has_point( position ) ):
		queue_free();


func _on_hurtbox_found_hitbox( hitbox: Hitbox ) -> void:
	hitbox.take_damage( 1 );
