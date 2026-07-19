extends Node
class_name EnemySpawner;


@export var _enemy_scenes: Array[ PackedScene ] = [];
@export var _spawn_time: float = 0.125 * 5;


var _spawn_timer: Timer;


func _ready() -> void:
	
	_spawn_timer = Timer.new();
	_spawn_timer.autostart = true;
	_spawn_timer.process_callback = Timer.TIMER_PROCESS_PHYSICS;
	_spawn_timer.wait_time = _spawn_time;
	add_child( _spawn_timer, false, Node.INTERNAL_MODE_BACK );
	_spawn_timer.timeout.connect( _on_spawn_timer_timeout, CONNECT_DEFERRED );


func _spawn_enemy() -> void:
	var enemy_scene: PackedScene = _enemy_scenes.pick_random();
	var enemy_node: Node = enemy_scene.instantiate();
	add_sibling( enemy_node );


func _on_spawn_timer_timeout() -> void:
	_spawn_enemy();
