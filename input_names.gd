@abstract
@tool
extends Object;
class_name InputNames;


@abstract class Move:
	extends Object;
	
	const RIGHT := &"Move Right";
	const DOWN := &"Move Down";
	const LEFT := &"Move Left";
	const UP := &"Move Up";
	
	static func get_dir() -> Vector2:
		return Input.get_vector( UP, DOWN, LEFT, RIGHT );


const ACCEPT := &"Accept";
const CANCEL := &"Cancel";
const SPECIAL := &"Special";
