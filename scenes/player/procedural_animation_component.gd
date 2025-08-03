extends Node3D
class_name ProceduralAnimationComponent

@export_group("Procedural animation")
@export var isAnimated: bool = false
@export var node_array: Array = []

func _process(delta):
	if isAnimated:
		for i in range(node_array.size() - 1):
			ScaleDistance(node_array[i], node_array[i + 1], - 50)

func ScaleDistance(anchor, point, distance: float):
	var dist_vec = GetDistanceVector(anchor, point)
	point.global_position = anchor.global_position - dist_vec * distance

func GetDistanceVector(a: Node2D, b: Node2D):
	var x_diff = b.global_position.x - a.global_position.x
	var y_diff = b.global_position.y - a.global_position.y
	if y_diff < 0:
		y_diff /= 3 
	var vect = Vector2(x_diff, y_diff)
	var result = vect.normalized()
	return result
