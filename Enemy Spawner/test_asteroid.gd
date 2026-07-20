extends Node2D;


const SPEED := 300.0;


func _ready() -> void:
	
	position.x = Consts.SCREEN_SIZE.x * randf();
	position.y = Consts.SCREEN_SIZE.y;
	
	$Sprite2D.rotate( TAU * randf() );

func _physics_process( delta: float ) -> void:
	
	translate( delta * SPEED * Vector2.UP );
	if ( position.y < 0.0 ):
		queue_free();


func _on_hurtbox_found_hitbox( hitbox: Hitbox ) -> void:
	hitbox.take_damage( 1 );
