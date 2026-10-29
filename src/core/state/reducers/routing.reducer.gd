class_name RoutingReducer
extends Reducer

static func reduce(state: State, routerEvent: RouterEvent) -> Array[Event]:
	match routerEvent.type:
		RouterEvent.Type.REQUEST_ROUTE_CHANGE:
			return _onRouteChangeRequested(state, routerEvent)
		_:
			return RoutingReducer._return([])

static func _onRouteChangeRequested(state: State, routerEvent: RouterEvent) -> Array[Event]:
	var events: Array[Event] = []

	if state.route == routerEvent.route:
		EventBus.emit(DebugEvent.new("Already on route: %s" % routerEvent.route))
		return []
	
	state.route = routerEvent.route
	events.append(RouterEvent.new(RouterEvent.Type.CHANGE_ROUTE, routerEvent.route))
	return events
