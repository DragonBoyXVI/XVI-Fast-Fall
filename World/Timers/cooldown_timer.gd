@tool
extends Timer;
class_name CooldownTimer;


func _init() -> void:
	
	process_callback = Timer.TIMER_PROCESS_PHYSICS;
	one_shot = true;
