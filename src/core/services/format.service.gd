class_name FormatService
extends RefCounted

static func formatObject(value: Object, visited: Dictionary) -> String:
	var instance_id := value.get_instance_id()
	if visited.has(instance_id):
		return "<cycle>"
	visited[instance_id] = true

	var properties: Array[String] = []
	for property: Dictionary in value.get_property_list():
		if property.usage & PROPERTY_USAGE_SCRIPT_VARIABLE:
			properties.append("%s: %s" % [property.name, FormatService.formatValue(value.get(property.name), visited)])

	visited.erase(instance_id)
	return "{%s}" % ", ".join(PackedStringArray(properties))

static func formatValue(value: Variant, visited: Dictionary) -> String:
	if value is Object:
		return FormatService.formatObject(value, visited)
	if value is Array:
		var items: Array[String] = []
		for item: Variant in value:
			items.append(FormatService.formatValue(item, visited))
		return "[%s]" % ", ".join(PackedStringArray(items))
	if value is Dictionary:
		var entries: Array[String] = []
		for key: Variant in value:
			entries.append("%s: %s" % [var_to_str(key), FormatService.formatValue(value[key], visited)])
		return "{%s}" % ", ".join(PackedStringArray(entries))
	return var_to_str(value)
