class_name EventSubscriber
extends RefCounted

var events: Dictionary[Event.DOMAIN, Callable] = {}

func _init(e: Dictionary[Event.DOMAIN, Callable]) -> void:
	events = e
	EventBus.queue.connect(_on_event)

func destroy() -> void:
	EventBus.queue.disconnect(_on_event)

func _on_event(event: Event) -> void:
	if events.has(event.domain):
		events[event.domain].call(event)
