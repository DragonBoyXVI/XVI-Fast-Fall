@tool
extends Node2D;
class_name HealthNode;
## Keeps track of an hp value, and optionally draws a healthbar to
## the screen.
##
## hlpth


## Emitted whenever the health values change.
signal health_changed( current_health: int, max_health: int );
## Emitted when this health node dies.
## Dead health nodes can no longer be interacted with.
signal died();


## The base amount of hp this node wil have before scaling.
@export var _base_health: int = 5:
	set( new ):
		_base_health = maxi( 1, new );



var _current_hp: int = 0;
var _max_hp: int = 0;

var _is_dead: bool = false;


func _ready() -> void:
	
	if ( Engine.is_editor_hint() ):
		return;
	
	_max_hp = _base_health;
	_current_hp = _max_hp;


func get_current_health() -> int:
	return _current_hp;

func get_maximum_health() -> int:
	return _max_hp;

func get_health_percent() -> float:
	var percent: float = _current_hp / float( _max_hp );
	return clampf( percent, 0.0, 1.0 );


func take_damage( damage: DamageInst ) -> void:
	if ( _is_dead ):
		return;
	
	_current_hp -= damage.amount;
	health_changed.emit( _current_hp, _max_hp );
	
	if ( _current_hp <= 0 ):
		_is_dead = true;
		died.emit();

func take_heal( amount: int ) -> void:
	
	_current_hp = mini( _current_hp + amount, _max_hp );
	health_changed.emit( _current_hp, _max_hp );
