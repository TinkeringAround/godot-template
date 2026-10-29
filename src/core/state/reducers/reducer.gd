class_name Reducer
extends RefCounted

# Always casts to to correct return type - regardless of Events coming in
static func _return(events: Array[Event]) -> Array[Event]:
	var returnEvents: Array[Event] = events
	return returnEvents