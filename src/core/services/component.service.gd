class_name ComponentService
extends RefCounted

enum Component {
	Platform,
	Player,
	Enemy
}

static var uids: Dictionary[Component, String] = {
	Component.Platform: "uid://d1r3t74prt36v",
	Component.Player: "uid://bgoec7mt0tji6",
	Component.Enemy: "uid://d16ifuigwacbe"
}

static func load(component: Component) -> Node:
	if not uids.has(component):
		push_error("No resource configured for component: %s" % component)
		return null

	var uid: String = uids[component]
	var resource_id: int = ResourceUID.text_to_id(uid)
	if resource_id == ResourceUID.INVALID_ID:
		push_error("Invalid resource UID for component %s: %s" % [component, uid])
		return null

	var resource_path: String = ResourceUID.get_id_path(resource_id)
	if resource_path.is_empty():
		push_error("Could not resolve resource UID for component %s: %s" % [component, uid])
		return null

	var packed_scene := ResourceLoader.load(resource_path) as PackedScene
	if packed_scene == null:
		push_error("Could not load component scene %s: %s" % [component, resource_path])
		return null

	return packed_scene.instantiate()
