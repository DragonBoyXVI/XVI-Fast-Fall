@tool
extends Button;
class_name FFButton;


const _DOWN: AudioStream = preload("uid://baf0bk80ooe1k");
const _UP: AudioStream = preload("uid://baf0bk80ooe1k");

const _PSCALE := ^"offset_transform_scale";
const _PPOS := ^"offset_transform_position";
const _PROT := ^"offset_transform_rotation";

const _BUT_DOWN_SCALE_AMT := Vector2.ONE * 0.95;
const _POS_AMT := Vector2( 0.0, 2.0 );
const _SCALE_AMT := Vector2.ONE * 1.05;
const _ROT_AMT := deg_to_rad( 5.0 );
const _TIME := 0.125;


var _tween: Tween;


func _init() -> void:
	
	if ( Engine.is_editor_hint() ):
		return;
	
	offset_transform_enabled = true;
	
	focus_entered.connect( GlobalSfx.focused );
	mouse_entered.connect( grab_focus, CONNECT_DEFERRED );
	
	focus_entered.connect( _m_focus );
	focus_exited.connect( _unfocused );
	
	button_down.connect( GlobalSfx.button_down );
	button_down.connect( _bdown );
	button_up.connect( GlobalSfx.button_up );
	button_up.connect( _bup );


func _refresh_tween() -> void:
	if ( _tween and _tween.is_running() ):
		_tween.kill();
	
	_tween = create_tween();
	_tween.set_ignore_time_scale();
	_tween.set_pause_mode( Tween.TWEEN_PAUSE_PROCESS );

# focus with gamepad
func _gp_focus() -> void:
	_refresh_tween();
	_tween.set_parallel();
	_tween.set_trans( Tween.TRANS_BOUNCE );
	
	_tween.tween_property( self, _PSCALE, _SCALE_AMT, _TIME );
	_tween.tween_property( self, _PPOS, _POS_AMT, _TIME );

# focus with mouse
func _m_focus() -> void:
	_refresh_tween();
	
	var center_pos: Vector2 = get_global_rect().get_center();
	var mouse_pos: Vector2 = get_global_mouse_position();
	var is_right: bool = center_pos.x < mouse_pos.x;
	var is_top: bool = center_pos.y < mouse_pos.y;
	
	var tip_right_side: bool;
	if ( is_right ):
		tip_right_side = is_top;
	else:
		tip_right_side = !is_top;
	
	var rot_amt: float = _ROT_AMT * ( 1.0 if tip_right_side else -1.0 );
	_tween.tween_property( self, _PROT, rot_amt, _TIME * 0.5 );
	_tween.tween_property( self, _PROT, 0.0, _TIME * 0.5 );
	
	_tween.set_parallel();
	_tween.tween_property( self, _PSCALE, _SCALE_AMT, _TIME );

# unfocused
func _unfocused() -> void:
	_refresh_tween();
	_tween.set_parallel();
	_tween.set_trans( Tween.TRANS_BOUNCE );
	
	_tween.tween_property( self, _PSCALE, Vector2.ONE, _TIME );
	_tween.tween_property( self, _PPOS, Vector2.ZERO, _TIME );
	_tween.tween_property( self, _PROT, 0.0, _TIME );

func _bdown() -> void:
	_refresh_tween();
	_tween.set_parallel();
	
	_tween.tween_property( self, _PSCALE, _BUT_DOWN_SCALE_AMT, _TIME * 0.25 );

func _bup() -> void:
	_refresh_tween();
	_tween.set_trans( Tween.TRANS_BOUNCE );
	_tween.set_parallel();
	
	_tween.tween_property( self, _PSCALE, _SCALE_AMT, _TIME );
	_tween.finished.connect(
		func() -> void:
			if ( has_focus() ):
				pass;
			else:
				_unfocused();
	,CONNECT_DEFERRED);
