extends RefCounted;
class_name Bullet;


var owner: Node2D;
var body_rid: RID;

var position: Vector2;
var direction: float;
var speed: float;

var team: Consts.Team;
