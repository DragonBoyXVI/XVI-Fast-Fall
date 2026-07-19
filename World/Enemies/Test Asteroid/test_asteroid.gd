extends Node2D


@onready var _health: HealthNode2D = $HealthNode2D;


func _ready() -> void:
	
	position.y = Consts.SCREEN_SIZE.y;
	position.x = randf() * Consts.SCREEN_SIZE.x;

func _physics_process( delta: float ) -> void:
	
	const SPEED = 300.0;
	position.y -= SPEED * delta;
	if ( position.y <= 0 ):
		queue_free();


func _on_hitbox_2d_took_damage( damage: DamageInst ) -> void:
	_health.damage( damage );

func _on_hurtbox_2d_hitbox_entered( hitbox: Hitbox2D ) -> void:
	hitbox.take_damage( DamageInst.new( 1 ) );

func _on_health_node_2d_died() -> void:
	queue_free();
