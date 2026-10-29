class_name SceneController
extends Controller

@export var scenes: Node

var sceneUids: Dictionary[Routes.Value, String] = {
	Routes.Value.HOME: "uid://y8xvb5yt484u",
}

var currentScene: Node
var isLoading: bool = false

func _ready() -> void:
	events = {
		Event.DOMAIN.ROUTER: Callable(self, "_onRouteEvent")
	}
	super._ready()
	
func _onRouteEvent(event: RouterEvent) -> void:
	if event.type == RouterEvent.Type.CHANGE_ROUTE:
		_loadRoute(event.route)

func _loadRoute(route: Routes.Value) -> void:
	if isLoading:
		return

	if not sceneUids.has(route):
		push_error("No scene configured for route: %s" % route)
		return

	var scene_uid: String = sceneUids[route]
	var resource_id: int = ResourceUID.text_to_id(scene_uid)
	if resource_id == ResourceUID.INVALID_ID:
		push_error("Invalid scene UID for route %s: %s" % [route, scene_uid])
		return

	var scene_path: String = ResourceUID.get_id_path(resource_id)
	if scene_path.is_empty():
		push_error("Could not resolve scene UID for route %s: %s" % [route, scene_uid])
		return

	var packed_scene: PackedScene = load(scene_path) as PackedScene
	if packed_scene == null:
		push_error("Could not load scene for route %s: %s" % [route, scene_path])
		return

	isLoading = true
	_cleanScenes()
	await get_tree().process_frame

	currentScene = packed_scene.instantiate()
	scenes.add_child(currentScene)
	isLoading = false

func _cleanScenes() -> void:
	currentScene = null
	for child in scenes.get_children():
		child.queue_free()
