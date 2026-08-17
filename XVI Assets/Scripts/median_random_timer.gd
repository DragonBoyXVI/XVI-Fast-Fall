@tool
extends Timer;
class_name MedianRandomTimer;
## A random deviation timer, good for varied randomness.
##
## call "start_random" to used the random part.


## The deviation from the normal timers wait_time.
@export var deviation: float = 1.0;


func start_random() -> void:
	start( randfn( wait_time, deviation ) );
