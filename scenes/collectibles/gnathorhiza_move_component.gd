extends Node3D

enum state {
	IDLE,
	MOVING_LEFT,
	MOVING_RIGHT
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
	
	ChangeState(state.MOVING_RIGHT)

func _physics_process(delta):
	match current_state:
		state.IDLE:
			pass
		state.MOVING_LEFT:
			parent.position += Vector3(delta * SPEED, 0, 0)
		state.MOVING_RIGHT:
			parent.position -= Vector3(delta * SPEED, 0, 0)

func ChangeState(new_state: state):
	current_state = new_state
	if new_state == state.MOVING_LEFT:
		timer.start(5)
		# animate
	elif new_state == state.MOVING_RIGHT:
		timer.start(5)
		# animate

func _on_timer_timeout():
	if current_state == state.MOVING_LEFT:
		ChangeState(state.MOVING_RIGHT)
	elif current_state == state.MOVING_RIGHT:
		ChangeState(state.MOVING_LEFT)
