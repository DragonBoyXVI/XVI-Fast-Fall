extends Node


#region Game State

signal pause_changed( is_paused: bool );
func emit_pause_changed( is_paused: bool ) -> void:
	pause_changed.emit( is_paused );

#endregion Game State

#region Menus

signal menu_requested( menu: Consts.Menu );
func request_menu( menu: Consts.Menu ) -> void:
	menu_requested.emit( menu );

#endregion Menus

#region Settings

signal settings_changed();
func emit_settings_changed() -> void:
	settings_changed.emit();

#endregion Settings

#region Bullets

#signal bullet_fired( bullet: Bullet );
#func fire_bullet( bullet: Bullet ) -> void:
#	bullet_fired.emit( bullet );

#signal bullet_hit_someone( bullet: Bullet, Owner: Node, Target: Node );

#endregion Bullets
