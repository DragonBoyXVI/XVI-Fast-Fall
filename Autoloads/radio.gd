extends Node


#region Game State

signal pause_changed( is_paused: bool );
func emit_pause_changed( is_paused: bool ) -> void:
	pause_changed.emit( is_paused );

signal player_died();
func emit_player_died() -> void:
	player_died.emit();

signal start_round();
func emit_start_round() -> void:
	start_round.emit();

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

## Emitted when a bullet from the bullet system hits a [Hitbox].
## Intended to be caught by said [Hitbox] so it can send info to the normal damage pipeline.
signal bullet_hit_hitbox( hitbox_rid: RID, damage: DamageInst );
func emit_bullet_hit_hitbox( hitbox_rid: RID, damage: DamageInst ) -> void:
	bullet_hit_hitbox.emit( hitbox_rid, damage );

#endregion BulletSystem

#region Menus

signal open_menu_requested( menu: Consts.Menu );
func request_open_menu( menu: Consts.Menu ) -> void:
	open_menu_requested.emit( menu );

#endregion Menues

#region QuotaSystem

## Emitted when the quota for this room has been reached.
signal quota_reached();
func emit_quota_reached() -> void:
	quota_reached.emit();

#endregion QuotaSystem
