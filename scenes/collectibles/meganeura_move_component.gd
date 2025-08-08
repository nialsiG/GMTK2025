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
@onready var backwing_sprite = $"../Sprite3D/BackwingSprite"
@onready var forewing_sprite = $"../Sprite3D/ForewingSprite"

var current_state: state = state.IDLE
var timer = 0.0
var fly_speed = 5.0
var scale_factor = -1.0
var initial_wing_position: float

func _ready():
	initial_wing_position = backwing_sprite.position.y
	if parent.global_position.x < 0.0:
		FlipSprite()
	SignalManager.PlayerAtSurface.connect(Fly)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	backwing_sprite.scale.y += scale_factor * fly_speed * delta
	forewing_sprite.scale.y += scale_factor * fly_speed * delta
	backwing_sprite.position.y = initial_wing_position * backwing_sprite.scale.y
	forewing_sprite.position.y = initial_wing_position * forewing_sprite.scale.y
	if backwing_sprite.scale.y < 0.2 or backwing_sprite.scale.y > 1.0:
		scale_factor *= -1
	
	var distance = GlobalVariables.player_global_position - parent.global_position
	# state machine
	match current_state:
		state.IDLE:
			pass
		state.FLEEING:
			fly_speed = 30.0
			parent.position -= Vector3(distance.x, - 1, 0).normalized() * SPEED * delta
			if distance.x < 0:
				sprite_3d.scale.x = -1.0
			else:
				sprite_3d.scale.x = 1.0

func FlipSprite():
	sprite_3d.scale.x *= -1.0

func Fly():
	current_state = state.FLEEING
