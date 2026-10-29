class_name SignalService
extends Node

static func await_all(signals: Array[Signal]) -> void:
	if signals.is_empty():
		return
	
	var remaining: Array[int] = [signals.size()]
	for sig in signals:
		sig.connect(func(): remaining[0] -= 1, CONNECT_ONE_SHOT)
	
	while remaining[0] > 0:
		await Engine.get_main_loop().process_frame

static func signal_resolve() -> Signal:
	var scene_tree := Engine.get_main_loop() as SceneTree
	return scene_tree.create_timer(0.0).timeout
