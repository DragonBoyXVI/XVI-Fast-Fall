extends Node2D


const SPEED: Vector2 = 300.0 * Vector2.UP;


func _physics_process( delta: float ) -> void:
	translate( SPEED * delta );
	if ( position.y < 0 ):
		position.y += Consts.SCREEN_SIZE.y + 50;
		reset_physics_interpolation();


func _on_hurtbox_found_hitbox( hitbox: Hitbox ) -> void:
	hitbox.take_hit( DamageInst.new( randi() % 3 + 2 ) );
