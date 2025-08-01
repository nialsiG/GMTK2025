extends Node3D
class_name RiverChunk

const SPEED = 2

@onready var dimetrodon_prefab = load("res://scenes/obstacles/obstacle_dimetrodon.tscn")

func _process(delta):
	position += Vector3 (0, 0, SPEED * delta)
	if position.z >= 5:
		SignalManager.NewRiverChunk.emit(Vector3(0,0,-10))
		await get_tree().create_timer(0.05).timeout
		queue_free()

func SpawnObstacle(type, origin: Vector3):
	var obstacle: Obstacle
	match type:
		Enums.ObstacleType.DIMETRODON:
			obstacle = dimetrodon_prefab.instantiate()
	obstacle.position = origin
	add_child(obstacle)
