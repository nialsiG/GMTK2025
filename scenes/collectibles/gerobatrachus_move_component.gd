extends Node3D

enum state {
	IDLE,
	MOVING_UP,
	MOVING_DOWN
}

const SPEED = 2

# nodes
@onready var timer = $Timer

# runtime variables
var parent: Collectible
var current_state: state = state.IDLE

func _ready():
	parent = get_parent()
	await get_tree().create_timer(randf_range(0.1, 1.1)).timeout
	ChangeState(state.MOVING_DOWN)

func _physics_process(delta):
	match current_state:
		state.IDLE:
			pass
		state.MOVING_UP:
			parent.position += Vector3(0, delta * SPEED, 0)
		state.MOVING_DOWN:
			parent.position -= Vector3(0, delta * SPEED / 3, 0)

func ChangeState(new_state: state):
	current_state = new_state
	if new_state == state.MOVING_UP:
		timer.start(1)
		# animate
	elif new_state == state.MOVING_DOWN:
		timer.start(3)
		# animate

func _on_timer_timeout():
	if current_state == state.MOVING_UP:
		ChangeState(state.MOVING_DOWN)
	elif current_state == state.MOVING_DOWN:
		ChangeState(state.MOVING_UP)
