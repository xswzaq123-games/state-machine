class_name StateMachine
extends WeakRef

signal state_changed(prev_state: int)

var states: Dictionary[int, aBaseStateInterface]
var current_state: aBaseStateInterface
var _current_state_key: int
var owner: WeakRef


func update(delta: float) -> void:
	if current_state:
		current_state.update(delta)


func physics_update(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)


func handle_input(event: InputEvent) -> void:
	if current_state:
		current_state.handle_input(event)


func add_state(state_key: int, state: aStateInterface) -> void:
	states[state_key] = state
	state.set_machine(self)


func change_state(new_state_key: int) -> void:
	var prev_state_key: int = _current_state_key
	if current_state:
		current_state.exit()

	_current_state_key = new_state_key
	current_state = states.get(_current_state_key)


	if current_state:
		current_state.enter(prev_state_key)
		state_changed.emit(prev_state_key)
	else:
		push_warning(get_current_state_name() + " state not found")


func set_initial_state(state_key: int) -> void:
	change_state(state_key)


func get_current_state() -> int:
	return _current_state_key


func get_current_state_name() -> String:
	return get_owner().States.keys()[_current_state_key]


func set_owner(_owner: Variant) -> void:
	owner = weakref(_owner)


func get_owner() -> Variant:
	return owner.get_ref()
