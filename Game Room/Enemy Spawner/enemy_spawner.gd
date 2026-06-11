
extends Node;
class_name EnemySpawner;


const _SPAWN_TIME = 0.8;


@export var _spawnable_scenes: Array[ PackedScene ] = [];


var _timer: Timer;


func _ready() -> void:
	
	if ( Engine.is_editor_hint() ):
		return;
	
	_timer = Timer.new();
	_timer.wait_time = _SPAWN_TIME;
	_timer.autostart = true;
	_timer.one_shot = false;
	_timer.process_callback = Timer.TIMER_PROCESS_PHYSICS;
	_timer.timeout.connect( _on_timer_timeout );
	add_child( _timer );


func _on_timer_timeout() -> void:
	
	var spawn_scene: PackedScene = _spawnable_scenes.pick_random();
	var spawn_node: Node = spawn_scene.instantiate();
	add_sibling( spawn_node );
