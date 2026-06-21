extends Node


#region Game State

#endregion Game State

#region Settings

signal settings_changed();
func emit_settings_changed() -> void:
	settings_changed.emit();

#endregion Settings

#region Bullets

signal bullet_fired( bullet: Bullet );
func fire_bullet( bullet: Bullet ) -> void:
	bullet_fired.emit( bullet );

#signal bullet_hit_someone( bullet: Bullet, Owner: Node, Target: Node );

#endregion Bullets
