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

## Emitted when a bullet from the bullet system hits a [Hitbox].
## Intended to be caught by said [Hitbox] so it can send info to the normal damage pipeline.
signal bullet_hit_hitbox( hitbox_rid: RID, damage: DamageInst );
func emit_bullet_hit_hitbox( hitbox_rid: RID, damage: DamageInst ) -> void:
	bullet_hit_hitbox.emit( hitbox_rid, damage );

#endregion BulletSystem
