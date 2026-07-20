@tool
extends Control;
class_name ScreenFaderBase;


const ANIM_HIDE := &"hide";
const ANIM_SHOW := &"show";


@export var _animation_player: AnimationPlayer:
	set( new ):
		_animation_player = new;
		update_configuration_warnings();


func _ready() -> void:
	
	if ( Engine.is_editor_hint() ):
		
		if ( not _animation_player ):
			
			_animation_player = AnimationPlayer.new();
			add_child( _animation_player, true );
			_animation_player.root_node = _animation_player.get_path_to( self );
			_animation_player.owner = self;
		
		return;
	
	Radio.screen_show_requested.connect( _on_radio_screen_show_requested );
	Radio.screen_hide_requested.connect( _on_radio_screen_hide_requested );

func _get_configuration_warnings() -> PackedStringArray:
	
	if ( not _animation_player ):
		return [ "No animation player!" ];
	
	return [];


func _on_radio_screen_show_requested() -> void:
	if ( GameState.screen_fade_state == GameState.ScreenFadeState.FADING_OUT ):
		return;
	if ( GameState.screen_fade_state == GameState.ScreenFadeState.FADING_IN ):
		await Radio.screen_hidden;
	
	_animation_player.play( ANIM_SHOW )
	GameState.screen_fade_state = GameState.ScreenFadeState.FADING_OUT;
	
	await _animation_player.animation_finished;
	
	GameState.screen_fade_state = GameState.ScreenFadeState.IDLE;
	Radio.emit_screen_shown()

func _on_radio_screen_hide_requested() -> void:
	if ( GameState.screen_fade_state == GameState.ScreenFadeState.FADING_IN ):
		return;
	if ( GameState.screen_fade_state == GameState.ScreenFadeState.FADING_OUT ):
		await Radio.screen_shown;
	
	_animation_player.play( ANIM_HIDE )
	GameState.screen_fade_state = GameState.ScreenFadeState.FADING_IN;
	
	await _animation_player.animation_finished;
	
	GameState.screen_fade_state = GameState.ScreenFadeState.HIDDEN;
	Radio.emit_screen_hidden()
