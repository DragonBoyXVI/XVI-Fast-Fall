@abstract
@tool
extends Object;
class_name XVIFuncs;
## Global class with some useful functions.
##
## Destription 2 waow.


## Sets ALL node processes to enabled or disabled, dependig on whats given to
## the "enabled" argument.
## By default, this will disable all processes.
static func set_node_processes( node: Node, enabled: bool = false ) -> void:
	
	node.set_process( enabled );
	node.set_physics_process( enabled );
	node.set_process_input( enabled );
	node.set_process_shortcut_input( enabled );
	node.set_process_unhandled_input( enabled );
	node.set_process_unhandled_key_input( enabled );
