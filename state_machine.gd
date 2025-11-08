class_name StateMachine
extends WeakRef

signal state_changed(prev_state: int)

var states: Dictionary[int, aBaseStateInterface]
var _current_state: aBaseStateInterface
var _current_state_key: int
var _owner: WeakRef


func update(delta: float) -> void:
	if _current_state:
		_current_state.update(delta)


func physics_update(delta: float) -> void:
	if _current_state:
		_current_state.physics_update(delta)


func handle_input(event: InputEvent) -> void:
	if _current_state:
		_current_state.handle_input(event)


func add_state(state_key: int, state: aStateInterface) -> void:
	states[state_key] = state
	state.set_machine(self)


func change_state(new_state_key: int) -> void:
	var prev_state_key: int =  _current_state_key
	if _current_state:
		_current_state.exit()

	_current_state_key = new_state_key
	_current_state = states.get( _current_state_key)


	if _current_state:
		_current_state.enter(prev_state_key)
		state_changed.emit(prev_state_key)
	else:
		push_warning(get_current_state_name() + " state not found")


func set_initial_state(state_key: int) -> void:
	change_state(state_key)


## Returns reference to the state
func get_current_state() -> aBaseStateInterface:
	if not _current_state:
		return null
	return _current_state


## Returns the key of the state
func get_current_state_key() -> int:
	return _current_state_key


## Returns the name of the state
func get_current_state_name() -> StringName:
	var state_name: String = get_owner().States.keys()[_current_state_key]
	if state_name:
		return state_name
	else:
		return ""


func set_owner(node: Variant) -> void:
	_owner = weakref(node)


func get_owner() -> Variant:
	return _owner.get_ref()
