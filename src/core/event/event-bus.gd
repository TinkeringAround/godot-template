extends Node

signal queue(event: Event)
signal debug(msg: String)

func emit(event: Event) -> void:
    if Settings.DEBUG:
        print("[Eventbus]%s" % [event.toString()])

    EventBus.queue.emit(event)