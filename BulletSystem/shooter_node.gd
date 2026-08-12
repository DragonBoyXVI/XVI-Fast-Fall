@tool
extends Node2D;
class_name ShooterNode;
## Base node component that allows a scene to shoot bullets
##
## - This emits shoot signal
## - Parent listens and shoots?


static func rpm_to_sec( rpm: float ) -> float:
	return 60.0 / rpm;


## Emitted when this wants to shoot a bullet.
## Supplies its own transform for where the bullet should go.
signal shot_fired( bullet_transform: Transform2D );


## How many rounds per minute this can fire.
@export_custom( PROPERTY_HINT_RANGE, "8.0,256.0,0.01,or_greater,suffix:rpm" ) var _rpm: float = 120.0;


## When true, this is executing shoot logic.
var trigger_held: bool = false;


var _cache_rpm: float = 0.0;
var _can_shoot: bool = true;

var _timer: Timer;


func _ready() -> void:
	
	if ( Engine.is_editor_hint() ):
		return;
	
	_cache_rpm = rpm_to_sec( _rpm );
	
	_timer = Timer.new();
	add_child( _timer, false, Node.INTERNAL_MODE_BACK );
	_timer.one_shot = true;
	_timer.process_callback = Timer.TIMER_PROCESS_PHYSICS;
	_timer.timeout.connect( _on_timer_timeout );

func _physics_process( _delta: float ) -> void:
	if ( not trigger_held ): return;
	
	if ( _can_shoot ):
		_can_shoot = false;
		_timer.start( _cache_rpm );
		
		shot_fired.emit( global_transform );

func _draw() -> void:
	if ( not Engine.is_editor_hint() ):
		return;
	
	const line_length := 64.0;
	draw_line( Vector2.ZERO, Vector2.RIGHT * line_length, Hurtbox.SHAPE_COLOR, 1.0 );


func _on_timer_timeout() -> void:
	_can_shoot = true;
