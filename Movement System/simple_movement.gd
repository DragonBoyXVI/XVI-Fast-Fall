@tool
extends MovementComponent;
class_name SimpleMovement;
## Very simple movement, nothing really special
##
## ditto


## Speed this moves, in pix/sec.
@export var _speed: float = 400.0;
## Direction to move this in
@export var direction: Vector2 = Vector2.UP:
	set( new ):
		direction = new.normalized();


func _ready() -> void:
	super();
	
	if ( Engine.is_editor_hint() ):
		return;

func move( delta: float, dir: Vector2 = direction ) -> void:
	
	_target_node.translate( dir * _speed * delta );
