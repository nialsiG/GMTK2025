extends Node3D

enum state {
	IDLE,
	FLEEING
}

const SPEED = 3.0
const Z_THRESHOLD = 3.0

# nodes
@onready var parent = $".."
@onready var sprite_3d = $"../Sprite3D"


var current_state: state = state.IDLE
var timer = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var distance = GlobalVariables.player_global_position - parent.global_position
	# state machine
	match current_state:
		state.IDLE:
			if distance.z < Z_THRESHOLD and abs(distance.y) < 1.0:
				current_state = state.FLEEING
		state.FLEEING:
			parent.rotation_degrees += Vector3(0, 0, SPEED) * sin(timer)
			timer += delta * SPEED * 10
			parent.position -= Vector3(distance.x, 0, 0).normalized() * SPEED * delta
			if distance.x < 0:
				sprite_3d.scale.x = 1.0
			else:
				sprite_3d.scale.x = -1.0
