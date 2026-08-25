extends Node;
class_name EnemySpawner;


## Just spawn raw scenes randomly for now
@export var _enemy_scenes: Array[ PackedScene ] = [];


var _timer: Timer;


func _ready() -> void:
	
	_timer = Timer.new();
	_timer.process_callback = Timer.TIMER_PROCESS_PHYSICS;
	_timer.wait_time = 0.75;
	add_child( _timer );
	_timer.timeout.connect( _on_timer_timeout );
	
	Radio.start_round.connect( _on_radio_round_start, CONNECT_DEFERRED );


func _on_timer_timeout() -> void:
	if ( _enemy_scenes.is_empty() ):
		return;
	
	var scene: PackedScene = _enemy_scenes.pick_random();
	assert( scene.can_instantiate() );
	add_sibling( scene.instantiate() );

func _on_radio_round_start() -> void:
	_timer.start();
