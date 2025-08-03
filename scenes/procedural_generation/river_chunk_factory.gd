extends Node

# prefabs
# ...river chunks
const EMPTY_CHUNK = preload("res://scenes/procedural_generation/empty_chunk.tscn")
# ...obstacles
const OBSTACLE_DIMETRODON = preload("res://scenes/obstacles/obstacle_dimetrodon.tscn")
const OBSTACLE_ORTHACANTHUS = preload("res://scenes/obstacles/obstacle_orthacanthus.tscn")

# ...collectibles
const GEROBATRACHUS_COLLECTIBLE = preload("res://scenes/collectibles/gerobatrachus_collectible.tscn")
const GNATHORHIZA_COLLECTIBLE = preload("res://scenes/collectibles/gnathorhiza_collectible.tscn")
const MAMAYOCARIS_COLLECTIBLE = preload("res://scenes/collectibles/mamayocaris_collectible.tscn")
const MEGANEURA_COLLECTIBLE = preload("res://scenes/collectibles/meganeura_collectible.tscn")

func _ready():
	BuildNewChunk(Vector3(0,0,0))
	BuildNewChunk(Vector3(0,0,-5))
	BuildNewChunk(Vector3(0,0,-10))
	BuildNewChunk(Vector3(0,0,-15))
	BuildNewChunk(Vector3(0,0,-20))
	BuildNewChunk(Vector3(0,0,-25))
	BuildNewChunk(Vector3(0,0,-30))
	SignalManager.NewRiverChunk.connect(BuildNewChunk)

func SpawnObstacle(parent, type: Enums.ObstacleType, origin: Vector3):
	var obstacle: Obstacle
	match type:
		Enums.ObstacleType.DIMETRODON:
			obstacle = OBSTACLE_DIMETRODON.instantiate()
		Enums.ObstacleType.DIPLOCAULUS:
			pass
		Enums.ObstacleType.ORTHACANTHUS:
			obstacle = OBSTACLE_ORTHACANTHUS.instantiate()
	obstacle.position = origin
	parent.add_child(obstacle)
	SignalManager.GameOver.connect(obstacle.queue_free)

func SpawnCollectible(parent, type: Enums.CollectibleType, origin: Vector3):
	var collectible: Collectible
	match type:
		Enums.CollectibleType.GEROBATRACHUS:
			collectible = GEROBATRACHUS_COLLECTIBLE.instantiate()
		Enums.CollectibleType.GNATHORHIZA:
			collectible = GNATHORHIZA_COLLECTIBLE.instantiate()
		Enums.CollectibleType.MEGANEURA:
			pass
		Enums.CollectibleType.MAMAYOCARIS:
			pass
	collectible.position = origin
	parent.add_child(collectible)
	SignalManager.GameOver.connect(collectible.queue_free)


func BuildNewChunk(origin: Vector3, is_empty = false):
	var instance: RiverChunk = EMPTY_CHUNK.instantiate()
	instance.position = origin
	add_child(instance)
	if is_empty or !GlobalVariables.can_spawn:
		return
	
	var index = randi_range(0,10)
	match index:
		0:
			SpawnObstacle(instance, Enums.ObstacleType.DIMETRODON, Vector3(0,8,-5))
			pass
		1:
			SpawnCollectible(instance, Enums.CollectibleType.GEROBATRACHUS, Vector3(3,3,-5))
			SpawnObstacle(instance, Enums.ObstacleType.ORTHACANTHUS, Vector3(3,5,-10))
			pass
		2:
			SpawnCollectible(instance, Enums.CollectibleType.GEROBATRACHUS, Vector3(3,3,-5))
			SpawnCollectible(instance, Enums.CollectibleType.GEROBATRACHUS, Vector3(0,6,-7))
			pass
		3:
			SpawnCollectible(instance, Enums.CollectibleType.GEROBATRACHUS, Vector3(3,3,-5))
			SpawnObstacle(instance, Enums.ObstacleType.DIMETRODON, Vector3(0,8,-10))
			SpawnCollectible(instance, Enums.CollectibleType.GEROBATRACHUS, Vector3(0,6,-7))
			pass
		4:
			SpawnObstacle(instance, Enums.ObstacleType.DIMETRODON, Vector3(4,8,-5))
			pass
		5:
			SpawnObstacle(instance, Enums.ObstacleType.ORTHACANTHUS, Vector3(-2,5,-5))
			SpawnObstacle(instance, Enums.ObstacleType.ORTHACANTHUS, Vector3(4,2,-7))
			pass
		6:
			SpawnCollectible(instance, Enums.CollectibleType.GEROBATRACHUS, Vector3(-6,3,-5))
			SpawnCollectible(instance, Enums.CollectibleType.GEROBATRACHUS, Vector3(-3,2,-3))
			pass
		7:
			pass
		8:
			SpawnObstacle(instance, Enums.ObstacleType.ORTHACANTHUS, Vector3(0,2,-5))
			pass
		9:
			SpawnObstacle(instance, Enums.ObstacleType.ORTHACANTHUS, Vector3(0,2,-5))
			SpawnObstacle(instance, Enums.ObstacleType.DIMETRODON, Vector3(2,8,-5))
			pass
		10:
			pass
	
