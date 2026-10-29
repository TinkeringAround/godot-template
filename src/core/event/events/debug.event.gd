class_name DebugEvent
extends Event

var type: Type = Type.INFO
var message: String = ""
var node: Node = null

enum Type {
    INFO,
    WARN,
    ERROR
}

func _init(message: String, type: Type = Type.INFO, node: Node = null) -> void:
    super._init(Event.DOMAIN.DEBUG)
    self.type = type
    self.message = message
    self.node = node

func toString() -> String:
    var eventType: Variant = Type.find_key(type)
    return "%s[%s][%s]: %s" % [super.toString(), str(eventType) if eventType != null else str(type), node.to_string() if node != null else "", message]