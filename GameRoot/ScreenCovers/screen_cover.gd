@tool
extends Control;
class_name ObjScreenCover;


const ANIM_COVER := &"CoverScreen";
const ANIM_UNCOVER := &"UncoverScreen";


signal finished();


@export var _animation_player: AnimationPlayer:
	set( new ):
		_animation_player = new;
		update_configuration_warnings();


func _get_configuration_warnings() -> PackedStringArray:
	var warnings := PackedStringArray();
	
	if ( _animation_player == null ):
		warnings.append( "No animation player!!" );
	else:
		
		if ( not _animation_player.has_animation( ANIM_COVER ) ):
			warnings.append( "This needs to have an animation for covering the screen: %s" % ANIM_COVER );
		if ( not _animation_player.has_animation( ANIM_UNCOVER ) ):
			warnings.append( "this needs to have an animation for uncovering the screen: %s" % ANIM_UNCOVER )
	
	return warnings;

func _notification( what: int ) -> void:
	if ( what == NOTIFICATION_EDITOR_POST_SAVE ): update_configuration_warnings();


func cover_screen() -> void:
	_animation_player.play( ANIM_COVER );
	await _animation_player.animation_finished;
	finished.emit();

func uncover_screen() -> void:
	_animation_player.play( ANIM_UNCOVER );
	await _animation_player.animation_finished;
	finished.emit();
