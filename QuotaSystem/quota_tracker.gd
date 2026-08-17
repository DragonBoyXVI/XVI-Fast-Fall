@abstract
extends Node;
class_name QuotaTracker;
## Add this to a room to keep track of the current quota.
## when the quota is met, this emits a signal on the radio.
##
## qu


## Call to notify the game that the quota is done
func notifty_quota_done() -> void:
	Radio.emit_quota_reached();
