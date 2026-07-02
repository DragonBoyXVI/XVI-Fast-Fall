@tool
extends Node2D;
class_name Room;





func pause() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED;

func unpause() -> void:
	process_mode = Node.PROCESS_MODE_INHERIT;
