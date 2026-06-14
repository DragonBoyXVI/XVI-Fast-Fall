extends Node


#region Bullets

signal bullet_fired( bullet: Bullet );
func fire_bullet( bullet: Bullet ):
	bullet_fired.emit( bullet );

#endregion Bullets
