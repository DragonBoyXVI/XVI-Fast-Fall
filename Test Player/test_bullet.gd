extends Sprite2D


const SPEED := Vector2( 0.0, 600.0 );


const PLAY_AREA := Rect2(
	Vector2.ZERO,
	Consts.SCREEN_SIZE
);

func _physics_process( delta: float ) -> void:
	translate( SPEED * delta );
	
	if ( not PLAY_AREA.has_point( position ) ):
		queue_free();


func _on_hurtbox_found_hitbox( hitbox: Hitbox ) -> void:
	hitbox.take_damage( 1 );
