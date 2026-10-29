extends Node

# Router
var route: Routes.Value = Routes.Value.NONE

# Events
var events: Dictionary[Event.DOMAIN, Callable] = {
	Event.DOMAIN.ROUTER: Callable(RoutingReducer, "reduce"),
}

func _to_string() -> String:
	return FormatService.formatObject(self, {})

func _init() -> void:
	EventBus.queue.connect(_onEvent)

func _onEvent(event: Event) -> void:
	if events.has(event.domain):
		var returnEvents: Array[Event] = events[event.domain].call(self, event) as Array[Event]

		for returnEvent in returnEvents:
			EventBus.emit(returnEvent)
		
		# TODO: Exchange with writing to file
		# EventBus.emit(DebugEvent.new("[State]:  %s" % [self._to_string()]))
