extends Control;


const ANIM_IN := &"FadeIn";
const ANIM_OUT := &"FadeOut";


@onready var animation_player: AnimationPlayer = $AnimationPlayer;


func _ready() -> void:
	
	GameState.screen_fade_state = GameState.ScreenFadeState.IDLE;
	
	Radio.room_changed.connect( _on_radio_room_changed );
	Radio.room_change_requested.connect( _on_radio_room_change_requested );

func _play_in() -> void:
	
	GameState.screen_fade_state = GameState.ScreenFadeState.FADING_IN;
	animation_player.play( ANIM_IN );
	await animation_player.animation_finished;
	GameState.screen_fade_state = GameState.ScreenFadeState.HIDDEN;
	Radio.emit_screen_faded( true );

func _play_out() -> void:
	
	GameState.screen_fade_state = GameState.ScreenFadeState.FADING_OUT;
	animation_player.play( ANIM_OUT );
	await animation_player.animation_finished;
	GameState.screen_fade_state = GameState.ScreenFadeState.IDLE;
	Radio.emit_screen_faded( false );


func _on_radio_room_changed() -> void:
	if ( GameState.screen_fade_state != GameState.ScreenFadeState.IDLE ):
		_play_out();

func _on_radio_room_change_requested( _room_path: String ) -> void:
	_play_in();
