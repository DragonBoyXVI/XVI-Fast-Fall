@tool
extends RefCounted;
class_name DamageInst;
## An instance of damage.
##
## ouchie


## Whos responsible for dealing this damage
var responsible: Node = null;

## The amount of damage dealt.
var amount: int = 0;


func _init( amt: int = 0 ) -> void:
	amount = amt;
