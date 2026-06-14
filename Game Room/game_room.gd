@tool
extends Node2D;
class_name GameRoom;
## Bass class for the rooms where the shooting takes place.


const _PLAYER_SPAWN_POINT := Vector2( 0.5, 0.2 ) * Vector2( Consts.SCREEN_SIZE );
const _PLAYER_SCENE: PackedScene = preload( "res://Game Room/Player/player.tscn" );


var _player: Player;


func _ready() -> void:
	
	if ( Engine.is_editor_hint() ):
		return;
	
	_player = _PLAYER_SCENE.instantiate();
	add_child( _player );
	_player.global_position = _PLAYER_SPAWN_POINT;

func _validate_property( property: Dictionary ) -> void:
	FFFuncs.disable_prop_2ds( property );

func _notification( what: int ) -> void:
	if ( what == NOTIFICATION_EDITOR_POST_SAVE ):
		queue_redraw();

func _draw() -> void:
	
	if ( Engine.is_editor_hint() ):
		
		const PLAYER_SPAWN_COLOR := Color( Color.BLUE, 0.2 );
		draw_circle( _PLAYER_SPAWN_POINT, 8, PLAYER_SPAWN_COLOR );
		
		return;


func _input(event: InputEvent) -> void:
	if ( event is InputEventKey ):
		
		var count := 1;
		if ( event.shift_pressed ): count = 100;
		for _i in count:
			
			var bullet := BulletStandard.new();
			
			bullet.target = Bullet.Target.ALL;
			
			bullet.transform = Transform2D.IDENTITY.rotated( TAU * randf() );
			bullet.transform.origin = get_global_mouse_position();
			
			Radio.fire_bullet( bullet );


func pause() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED;

func unpause() -> void:
	process_mode = Node.PROCESS_MODE_INHERIT;
