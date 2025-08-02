extends Node3D
class_name RiverChunk

const SPEED = 2

@onready var dimetrodon_prefab = load("res://scenes/obstacles/obstacle_dimetrodon.tscn")
@onready var is_active: bool = true

func _process(delta):
	position += Vector3 (0, 0, SPEED * delta)
	if position.z >= 5 and is_active:
		SignalManager.NewRiverChunk.emit(Vector3(0,0,-10))
		is_active = false
	if !is_active:
		await get_tree().create_timer(0.05).timeout
		queue_free()

func SpawnObstacle(type, origin: Vector3):
	var obstacle: Obstacle
	match type:
		Enums.ObstacleType.DIMETRODON:
			obstacle = dimetrodon_prefab.instantiate()
	obstacle.position = origin
	add_child(obstacle)
