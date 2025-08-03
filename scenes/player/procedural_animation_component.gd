extends Node3D
class_name ProceduralAnimationComponent

const SWIM_SPEED = 5

@export_group("Procedural animation")
@export var isAnimated: bool = false
@export var node_array: Array[Node3D] = []

@onready var timer: Timer = $Timer

func _ready():
	for i in range(node_array.size() - 1):
		await get_tree().create_timer(0.2).timeout
		node_array[i + 1].swimming = true
		node_array[i + 1].StartTimer()

func _physics_process(delta):
	if isAnimated:
		for i in range(node_array.size() - 1):
			var segment = node_array[i + 1] as Segment
			if segment.swimming:
				segment.position.x += delta * SWIM_SPEED * segment.swim_direction
			ScaleDistance(node_array[i], node_array[i + 1], - 0.09)

func ScaleDistance(anchor, point, distance: float):
	var dist_vec = GetDistanceVector(anchor, point)
	point.global_position = anchor.global_position - dist_vec * distance

func GetDistanceVector(a: Node3D, b: Node3D):
	var x_diff = b.global_position.x - a.global_position.x
	var y_diff = b.global_position.y - a.global_position.y
	if y_diff > 0:
		y_diff /= 3 
	var vect = Vector3(x_diff, y_diff, 0)
	var result = vect.normalized()
	return result
