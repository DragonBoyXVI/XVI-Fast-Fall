@abstract
@tool
extends Object;
class_name InputNames;


# Arrows
const Move: Dictionary[ String, StringName ] = {
	"UP": &"Move Up",
	"RIGHT": &"Move Right",
	"DOWN": &"Move Down",
	"LEFT": &"Move Left",
};
static func get_move_dir() -> Vector2:
	return Input.get_vector( Move.LEFT, Move.RIGHT, Move.UP, Move.DOWN );

# Z
const ENTER := &"Enter";
# X
const BACK := &"Back";
# C
const SPECIAL := &"Special";
# Shift
const SLOW := &"Slow";
# P
const PAUSE := &"Pause";
