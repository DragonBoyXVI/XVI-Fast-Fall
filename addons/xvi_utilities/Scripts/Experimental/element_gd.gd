@tool
#@static_unload
extends Resource;
class_name _ElementGD;


enum Bits {
	NONE = 0,
	FIRE = 1<<0,
	ICE = 1<<1,
	VENOM = 1<<2,
	LIFE = 1<<3,
	ELEC = 1<<4,
}

enum Effectiveness {
	WEAK = -1,
	NEUTRAL = 0,
	STRONG = 1,
}


const BITS_STRING := "Fire:1,Ice:2,Venom:4,Life:8,Elec:16";
const BIT_COUNT = 5;
const FIRE := Bits.FIRE;
const ICE := Bits.ICE;
const VENOM := Bits.VENOM;
const LIFE := Bits.LIFE;
const ELEC := Bits.ELEC;
const _SUMMARY_PATH := "res://elementgd_summary.txt"


static var _cache: Dictionary[ String, int ] = {};


#region Tables =3

const TABLE_FIRE: Dictionary[ int, int ] = {
	FIRE: Effectiveness.NEUTRAL,
	ICE: Effectiveness.STRONG,
	VENOM: Effectiveness.STRONG,
	LIFE: Effectiveness.NEUTRAL,
	ELEC: Effectiveness.WEAK,
}

const TABLE_ICE: Dictionary[ int, int ] = {
	FIRE: Effectiveness.STRONG,
	ICE: Effectiveness.NEUTRAL,
	VENOM: Effectiveness.WEAK,
	LIFE: Effectiveness.NEUTRAL,
	ELEC: Effectiveness.WEAK,
}

const TABLE_VENOM: Dictionary[ int, int ] = {
	FIRE: Effectiveness.WEAK,
	ICE: Effectiveness.STRONG,
	VENOM: Effectiveness.NEUTRAL,
	LIFE: Effectiveness.STRONG,
	ELEC: Effectiveness.WEAK,
}

const TABLE_LIFE: Dictionary[ int, int ] = {
	FIRE: Effectiveness.NEUTRAL,
	ICE: Effectiveness.NEUTRAL,
	VENOM: Effectiveness.NEUTRAL,
	LIFE: Effectiveness.NEUTRAL,
	ELEC: Effectiveness.STRONG,
}

const TABLE_ELEC: Dictionary[ int, int ] = {
	FIRE: Effectiveness.NEUTRAL,
	ICE: Effectiveness.STRONG,
	VENOM: Effectiveness.STRONG,
	LIFE: Effectiveness.WEAK,
	ELEC: Effectiveness.STRONG,
}

const TABLE: Dictionary[ int, Dictionary ] = {
	FIRE: TABLE_FIRE,
	ICE: TABLE_ICE,
	VENOM: TABLE_VENOM,
	LIFE: TABLE_LIFE,
	ELEC: TABLE_ELEC,
}

#endregion


var current_element: int = Bits.NONE;


static func make_cache_key( elem1: Bits, elem2: Bits ) -> String:
	const format := "{0}:{1}";
	return format.format( [ elem1, elem2 ] );


func _init( elem: Bits = Bits.NONE ) -> void:
	current_element = elem;

func _get_property_list() -> Array[ Dictionary ]:
	var properties: Array[ Dictionary ] = [];
	
	properties.append( {
		Property.NAME: "current_element",
		Property.TYPE: TYPE_INT,
		Property.HINT: PROPERTY_HINT_FLAGS,
		Property.HINT_STRING: BITS_STRING,
	} );
	
	return properties;


func get_strength_against( defending_element: _ElementGD ) -> int:
	
	var cache_key = make_cache_key( current_element, defending_element.current_element );
	if ( _cache.has( cache_key ) ):
		return _cache[ cache_key ];
	
	var strength_value := 0;
	for i: int in BIT_COUNT:
		
		var atk_elem := 1<<i;
		if ( current_element & atk_elem ):
			
			for j: int in BIT_COUNT:
				
				var def_elem := 1<<j;
				if ( defending_element.current_element & def_elem ):
					strength_value += TABLE[ atk_elem ][ def_elem ];
	
	_cache.set( cache_key, strength_value );
	return strength_value;
