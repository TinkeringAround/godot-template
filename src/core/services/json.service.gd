class_name JsonService
extends RefCounted

enum Files {
    STAGES,
    LEVELS,
    ENEMIES,
    ITEMS
}

static var filePaths: Dictionary[Files, String] = {
    Files.STAGES: "res://src/core/data/stages.json",
    Files.LEVELS: "res://src/core/data/levels.json",
    Files.ENEMIES: "res://src/core/data/enemies.json",
    Files.ITEMS: "res://src/core/data/items.json"
}

static func load(file: Files) -> Dictionary:
    if not filePaths.has(file):
        EventBus.emit(DebugEvent.new("No JSON file configured for: %s" % file, DebugEvent.Type.WARN))
        return {}

    var filePath: String = filePaths[file]
    var dataFile := FileAccess.open(filePath, FileAccess.READ)
    if dataFile == null:
        EventBus.emit(DebugEvent.new("Could not open JSON file: %s" % filePath, DebugEvent.Type.WARN))
        return {}

    var json := JSON.new()
    var parseError := json.parse(dataFile.get_as_text())
    if parseError != OK:
        EventBus.emit(DebugEvent.new("Could not parse JSON file %s at line %d: %s" % [filePath, json.get_error_line(), json.get_error_message()], DebugEvent.Type.WARN))
        return {}

    if not json.data is Dictionary:
        EventBus.emit(DebugEvent.new("Expected a JSON object in file: %s" % filePath, DebugEvent.Type.WARN))
        return {}

    return json.data