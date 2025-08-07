extends Node3D

const SPEED = 0.5

# runtime variables
var parent: Obstacle

func _ready():
	parent = get_parent() as Obstacle

func _physics_process(delta):
	parent.position -= delta * SPEED * Vector3(1, 0, 0)
