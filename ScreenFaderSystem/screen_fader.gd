@tool
extends Control;
class_name ScreenFader;
## This class is inteded to be used as a base for scenes used by the [ScreenFaderManager].
## This crates an animation player, and all you do is give it the correctly
# named anims and call some functions on the track.


const ANIM_IN := &"fade_in";
const ANIM_OUT := &"fade_out";


signal anim_done();


## Anim player used to animate the fades
@export var _animation_player: AnimationPlayer:
	set( new ):
		_animation_player = new;
		update_configuration_warnings();


func _ready() -> void:
	
	if ( Engine.is_editor_hint() ):
		
		if ( not _animation_player ):
			
			_animation_player = AnimationPlayer.new();
			var anim_lib := AnimationLibrary.new()
			anim_lib.add_animation( ANIM_IN, Animation.new() );
			anim_lib.add_animation( ANIM_OUT, Animation.new() );
			_animation_player.add_animation_library( "", anim_lib );
			add_child( _animation_player, true );
			_animation_player.owner = self;
		
		
		set_anchors_preset( Control.PRESET_FULL_RECT );
		
		XVIFuncs.set_node_processes( self, false );
		return
	
	print( can_process() );

func _get_configuration_warnings() -> PackedStringArray:
	var warnings := PackedStringArray();
	
	if ( _animation_player ):
		
		if ( not _animation_player.has_animation( ANIM_IN ) ):
			warnings.append( "Anim player doesnt have the \"%s\" animation. Please add it and ensure it calls the functions described in the class." % ANIM_IN )
		if ( not _animation_player.has_animation( ANIM_OUT ) ):
			warnings.append( "Anim player doesnt have the \"%s\" animation. Please add it and ensure it calls the functions described in the class." % ANIM_OUT )
	else:
		warnings.append( "This does not have a ref to an animation player node!, Either add one, or close and reopen the scene to regenerate it." )
	
	return warnings;


func play_anim( anim: StringName ) -> void:
	
	assert( _animation_player.has_animation( anim ) );
	_animation_player.play( anim );
	await _animation_player.animation_finished;
	anim_done.emit();
