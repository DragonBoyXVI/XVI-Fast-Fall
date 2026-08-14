extends Node2D


const SPEED: Vector2 = 300.0 * Vector2.UP;


func _ready() -> void:
	
	position.y = Consts.SCREEN_SIZE.y + 64.0;
	position.x = Consts.SCREEN_SIZE.x * randf();
	reset_physics_interpolation();

func _physics_process( delta: float ) -> void:
	translate( SPEED * delta );
	if ( position.y < 0 ):
		position.y += Consts.SCREEN_SIZE.y + randf_range( 50.0, 100.0 );
		reset_physics_interpolation();


func _on_hurtbox_found_hitbox( hitbox: Hitbox ) -> void:
	hitbox.take_hit( DamageInst.new( randi() % 3 + 2 ) );


func _on_hitbox_was_hit( _dmg: DamageInst ) -> void:
	queue_free();
