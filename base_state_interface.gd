@abstract
class_name aBaseStateInterface
extends aStateInterface


@abstract
func enter(_prev_state: int = -1) -> void


@abstract
func exit() -> void


@abstract
func update(_delta: float) -> void


@abstract
func physics_update(_delta: float) -> void


@abstract
func handle_input(_event: InputEvent) -> void


func set_machine(machine: StateMachine) -> void:
	state_machine = weakref(machine)


func get_machine() -> StateMachine:
	return state_machine.get_ref()
