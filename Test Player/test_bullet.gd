extends Sprite2D


const DIRECTION := Vector2.DOWN;
const SPEED := 600.0;

const PLAY_AREA := Rect2(
	Vector2.ZERO,
	Consts.SCREEN_SIZE
);

func _physics_process( delta: float ) -> void:
	translate( DIRECTION * SPEED * delta );
	
	if ( not PLAY_AREA.has_point( position ) ):
		queue_free();
