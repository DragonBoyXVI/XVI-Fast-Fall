@tool
extends RefCounted;
class_name DamageInst;


var amount: int = 0;


func _init( amt: int = 0 ) -> void:
	amount = amt;
