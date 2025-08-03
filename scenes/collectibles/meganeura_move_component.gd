extends Node3D

enum state {
	IDLE,
	FLYING
}

const SPEED = 5

@onready var current_state: state = state.IDLE

func _ready():
	SignalManager.PlayerAtSurface.connect(Fly)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match current_state:
		state.IDLE:
			pass
		state.FLYING:
			global_position += Vector3(delta * SPEED, delta * SPEED / 2, 0)

func Fly():
	current_state = state.FLYING
