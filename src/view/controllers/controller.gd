class_name Controller
extends Node

var events: Dictionary[Event.DOMAIN, Callable] = {}

func _ready() -> void:
	EventBus.emit(DebugEvent.new("Init", DebugEvent.Type.INFO, self))
	EventBus.queue.connect(_on_event)

func _on_event(event: Event) -> void:
	if events.has(event.domain):
		events[event.domain].call(event)
