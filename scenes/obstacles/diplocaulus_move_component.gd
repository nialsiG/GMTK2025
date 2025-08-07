extends Node3D

enum state {
	HIDDEN, 
	AMBUSH
	}

const SPEED = 5.0
const Z_THRESHOLD = 3.0
const Y_THRESHOLD = 3.0

# nodes
@onready var sprite_3d_hidden = $"../Sprite3DHidden"
@onready var sprite_3d_ambush = $"../Sprite3DAmbush"
@onready var parent: Obstacle = $".."

# runtime variables
var current_state: state = state.HIDDEN

func _process(delta):
	var distance = GlobalVariables.player_global_position - parent.global_position
	print("distance = ", distance)
	# state machine
	match current_state:
		state.HIDDEN:
			if distance.z < Z_THRESHOLD and GlobalVariables.player_global_position.y < Y_THRESHOLD:
				sprite_3d_hidden.visible = false
				sprite_3d_ambush.visible = true
				current_state = state.AMBUSH
			else:
				parent.global_position.x += delta * SPEED * distance.normalized().x
		state.AMBUSH:
			if distance.z < 0.5:
				sprite_3d_ambush.visible = false
			parent.global_position.x += delta * SPEED * distance.normalized().x
			if distance.y > 0:
				parent.position.y += delta * SPEED
			elif distance.y < 0:
				parent.position.y -= delta * SPEED
