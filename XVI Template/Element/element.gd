@tool
extends Resource;
class_name Element;
## A pokemon-esque type table for my elementals.[br]
##
## Didiao


## What bits relate to what element.
enum Bit {
	## No elements.
	NONE = 0,
	
	## Heat and fire, mostly heat.
	FIRE = 1<<0,
	## Cold and ice, anything chilled.
	ICE = 1<<1,
	## Toxins and waste, not just organic venom.
	VENOM = 1<<2,
	## Plants and nature,
	LIFE = 1<<3,
	## Metal and electricity, machinery.
	ELEC = 1<<4,
	
	## ALL OF THEM
	ALL = 0b11111,
}

## How effective an element is when on offense to another element.
enum Effectiveness {
	WEAK = -1,
	NEUTRAL = 0,
	STRONG = 1,
}


#region Tables

## Offense effectivness for fire.
const TABLE_FIRE : Dictionary[ Bit, Effectiveness ] = {
	Bit.FIRE: Effectiveness.WEAK,
	Bit.ICE: Effectiveness.STRONG,
	Bit.VENOM: Effectiveness.STRONG,
	Bit.LIFE: Effectiveness.STRONG,
	Bit.ELEC: Effectiveness.WEAK,
}

## Offense effectivness for ice.
const TABLE_ICE : Dictionary[ Bit, Effectiveness ] = {
	Bit.FIRE: Effectiveness.STRONG,
	Bit.ICE: Effectiveness.WEAK,
	Bit.VENOM: Effectiveness.NEUTRAL,
	Bit.LIFE: Effectiveness.NEUTRAL,
	Bit.ELEC: Effectiveness.NEUTRAL,
}

## Offense effectivness for venom.
const TABLE_VENOM : Dictionary[ Bit, Effectiveness ] = {
	Bit.FIRE: Effectiveness.WEAK,
	Bit.ICE: Effectiveness.STRONG,
	Bit.VENOM: Effectiveness.NEUTRAL,
	Bit.LIFE: Effectiveness.STRONG,
	Bit.ELEC: Effectiveness.WEAK,
}

## Offense effectivness for life.
const TABLE_LIFE : Dictionary[ Bit, Effectiveness ] = {
	Bit.FIRE: Effectiveness.WEAK,
	Bit.ICE: Effectiveness.NEUTRAL,
	Bit.VENOM: Effectiveness.NEUTRAL,
	Bit.LIFE: Effectiveness.NEUTRAL,
	Bit.ELEC: Effectiveness.STRONG,
}

## Offense effectivness for electricity.
const TABLE_ELEC : Dictionary[ Bit, Effectiveness ] = {
	Bit.FIRE: Effectiveness.NEUTRAL,
	Bit.ICE: Effectiveness.STRONG,
	Bit.VENOM: Effectiveness.NEUTRAL,
	Bit.LIFE: Effectiveness.STRONG,
	Bit.ELEC: Effectiveness.STRONG,
}

## Table that links elements to their bit.
const TABLE: Dictionary[ Bit, Dictionary ] = {
	Bit.FIRE: TABLE_FIRE,
	Bit.ICE: TABLE_ICE,
	Bit.VENOM: TABLE_VENOM,
	Bit.LIFE: TABLE_LIFE,
	Bit.ELEC: TABLE_ELEC,
}

#endregion Tables


## How many elements there are.
const _ELEM_COUNT := 5;


## Stores calculated element results.
## Used to prevent expensive calcs every time we query element effectiveness.
static var _cache: Dictionary[ String, int ] = {};

## makes a key for storing/retriving a value from the cache.
static func _make_cache_key( elem_atk: Bit, elem_def: Bit ) -> String:
	const FORMAT := "%s:%s";
	return FORMAT % [ elem_atk, elem_def ];


static func _print_table() -> void:
	
	for i: int in _ELEM_COUNT:
		
		var atk_elem := 1<<i;
		var arr := as_names( atk_elem );
		
		for j: int in _ELEM_COUNT:
			var def_elem := 1<<j;
			arr.append( str( calc_strength( atk_elem, def_elem ) ) );
		
		print( arr );


## Calculates and stores the strength value between two element masks
static func calc_strength( atk_elems: Bit, def_elems: Bit ) -> int:
	
	var cache_key := _make_cache_key( atk_elems, def_elems );
	if ( cache_key in _cache ):
		return _cache[ cache_key ];
	
	var strength_value := 0;
	for i: int in _ELEM_COUNT:
		
		var atk_elem: int = 1<<i;
		if ( atk_elems & atk_elem ):
			
			var element_table := TABLE[ atk_elem ];
			for j: int in _ELEM_COUNT:
				
				var def_elem: int = 1<<j;
				if ( def_elems & def_elem ):
					strength_value += element_table[ def_elem ];
	
	if ( not Engine.is_editor_hint() ):
		_cache[ cache_key ] = strength_value;
	return strength_value;

## Turns a strength value into a float between 0.0 and 2.0. With 1.0 being the standard strength.
static func strength_to_mult( strength: int ) -> float:
	return 1.0 + ( strength / float( _ELEM_COUNT ) );

## Returns a string array that lists the elements in a mask.
## Meant for developer use.
static func as_names( mask: Bit ) -> PackedStringArray:
	
	var string_array := PackedStringArray();
	
	if ( mask & Bit.FIRE ): string_array.append( "Fire" );
	if ( mask & Bit.ICE ): string_array.append( "Ice" );
	if ( mask & Bit.VENOM ): string_array.append( "Venom" );
	if ( mask & Bit.LIFE ): string_array.append( "Life" );
	if ( mask & Bit.ELEC ): string_array.append( "Elec" );
	
	return string_array;


#@export_tool_button( "Print sum" ) var _sum_butt := _print_table;
## Elemental value of this object.
@export_flags( "Fire", "Ice", "Venom", "Life", "Electricity" ) var _element: int = Bit.NONE:
	set( new ):
		_element = new;
		emit_changed();


func _init( _elem := Bit.NONE ) -> void:
	_element = _elem;


## Get the element value of this object.
func get_element() -> Bit:
	return _element as Bit;

## Gets this element masks strength value against another element mask.
func get_strength_against( defending_element: Element ) -> int:
	return calc_strength( get_element(), defending_element.get_element() );
