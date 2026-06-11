
extends RefCounted;
class_name Damage;


var amount: int = 0;


func _init( amt := 0 ) -> void:
	amount = amt;
