extends Node3D
class_name RiverChunk

const SPEED = 5

# prefabs
# ...obstacles
@onready var dimetrodon_prefab = preload("res://scenes/obstacles/obstacle_dimetrodon.tscn")
# ...collectibles
@onready var gerobatrachus_prefab = preload("res://scenes/collectibles/gerobatrachus_collectible.tscn")

# runtime variables
@onready var is_active: bool = true

func _process(delta):
	position += Vector3 (0, 0, SPEED * delta)
	if position.z >= 5 and is_active:
		SignalManager.NewRiverChunk.emit(Vector3(0,0,-30))
		is_active = false
	if !is_active:
		await get_tree().create_timer(0.05).timeout
		queue_free()

func SpawnObstacle(type: Enums.ObstacleType, origin: Vector3):
	var obstacle: Obstacle
	match type:
		Enums.ObstacleType.DIMETRODON:
			obstacle = dimetrodon_prefab.instantiate()
	obstacle.position = origin
	add_child(obstacle)
	SignalManager.GameOver.connect(obstacle.queue_free)

func SpawnCollectible(type: Enums.CollectibleType, origin: Vector3):
	var collectible: Collectible
	match type:
		Enums.CollectibleType.GEROBATRACHUS:
			collectible = gerobatrachus_prefab.instantiate()
	collectible.position = origin
	add_child(collectible)
	SignalManager.GameOver.connect(collectible.queue_free)
