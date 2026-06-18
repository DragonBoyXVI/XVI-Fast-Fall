extends Node


#region Game State

#endregion Game State

#region Bullets

signal bullet_fired( bullet: Bullet );
func fire_bullet( bullet: Bullet ) -> void:
	bullet_fired.emit( bullet );

#signal bullet_hit_someone( bullet: Bullet, Owner: Node, Target: Node );

#endregion Bullets
