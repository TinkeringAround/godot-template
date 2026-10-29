extends Node2D

func _ready() -> void:
	EventBus.emit(RouterEvent.new(RouterEvent.Type.REQUEST_ROUTE_CHANGE, Routes.Value.HOME))
