class_name Event
extends RefCounted

enum DOMAIN {
	DEBUG,
	ROUTER,
	NONE,
	VIEW # Return Events - For events that are only relevant to the view layer, e.g. UI events
}

var domain: DOMAIN = DOMAIN.NONE

func _init(t: Event.DOMAIN) -> void:
	domain = t

func toString() -> String:
	var domainName: Variant = DOMAIN.find_key(domain)
	return "[%s]" % [str(domainName) if domainName != null else str(domain)]
