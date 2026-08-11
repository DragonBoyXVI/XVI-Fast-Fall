extends Node


#region Game State

signal pause_changed( is_paused: bool );
func emit_pause_changed( is_paused: bool ) -> void:
	pause_changed.emit( is_paused );

#endregion Game State

#region Settings

signal settings_changed();
func emit_settings_changed() -> void:
	settings_changed.emit();

#endregion Settings

#region BulletSystem

## Emitted when a bullet is fired.
signal bullet_fired( bullet: Bullet );
func fire_bullet( bullet: Bullet ) -> void:
	bullet_fired.emit( bullet );

#endregion BulletSystem
