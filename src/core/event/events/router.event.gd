class_name RouterEvent
extends Event

var route: Routes.Value
var type: Type = Type.REQUEST_ROUTE_CHANGE

enum Type {
    REQUEST_ROUTE_CHANGE,
    CHANGE_ROUTE
}

func _init(type: Type, route: Routes.Value) -> void:
    super._init(Event.DOMAIN.ROUTER)
    self.type = type
    self.route = route

func toString() -> String:
    var eventType: Variant = Type.find_key(type)
    var routeValue: Variant = Routes.Value.find_key(route)
    return "%s[%s]: %s" % [super.toString(), str(eventType) if eventType != null else str(type), str(routeValue) if routeValue != null else "no route"]