extends Node

# prefabs
# ...river chunks
const EMPTY_CHUNK = preload("res://scenes/procedural_generation/empty_chunk.tscn")
# ...obstacles
const OBSTACLE_DIMETRODON = preload("res://scenes/obstacles/obstacle_dimetrodon.tscn")
const OBSTACLE_ORTHACANTHUS = preload("res://scenes/obstacles/obstacle_orthacanthus.tscn")
const OBSTACLE_DIPLOCAULUS = preload("res://scenes/obstacles/obstacle_diplocaulus.tscn")

# ...collectibles
const GEROBATRACHUS_COLLECTIBLE = preload("res://scenes/collectibles/gerobatrachus_collectible.tscn")
const GNATHORHIZA_COLLECTIBLE = preload("res://scenes/collectibles/gnathorhiza_collectible.tscn")
const MAMAYOCARIS_COLLECTIBLE = preload("res://scenes/collectibles/mamayocaris_collectible.tscn")
const MEGANEURA_COLLECTIBLE = preload("res://scenes/collectibles/meganeura_collectible.tscn")

func _ready():
	BuildNewChunk(Vector3(0,0,0))
	BuildNewChunk(Vector3(0,0,-10))
	BuildNewChunk(Vector3(0,0,-20))
	BuildNewChunk(Vector3(0,0,-30))
	SignalManager.NewRiverChunk.connect(BuildNewChunk)

func SpawnObstacle(parent, type: Enums.ObstacleType, origin: Vector3):
	var obstacle: Obstacle
	match type:
		Enums.ObstacleType.DIMETRODON:
			obstacle = OBSTACLE_DIMETRODON.instantiate()
		Enums.ObstacleType.DIPLOCAULUS:
			obstacle = OBSTACLE_DIPLOCAULUS.instantiate()
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
			collectible = MEGANEURA_COLLECTIBLE.instantiate()
		Enums.CollectibleType.MAMAYOCARIS:
			collectible = MAMAYOCARIS_COLLECTIBLE.instantiate()
	collectible.position = origin
	parent.add_child(collectible)
	SignalManager.GameOver.connect(collectible.queue_free)


func BuildNewChunk(origin: Vector3, is_empty = false):
	var instance: RiverChunk = EMPTY_CHUNK.instantiate()
	instance.position = origin
	add_child(instance)
	if is_empty or !GlobalVariables.can_spawn:
		return
	
	var index = randi_range(0,5)
	#index = 3
	match index:
		0:
			SpawnObstacle(instance, Enums.ObstacleType.DIMETRODON, Vector3(1.8,8,4))
			SpawnObstacle(instance, Enums.ObstacleType.DIMETRODON, Vector3(2.4,8,0))
			SpawnObstacle(instance, Enums.ObstacleType.DIMETRODON, Vector3(3,8,-4))
			pass
		1:
			SpawnObstacle(instance, Enums.ObstacleType.ORTHACANTHUS, Vector3(-2,2,0))
			SpawnObstacle(instance, Enums.ObstacleType.ORTHACANTHUS, Vector3(0,3,-4))
			SpawnObstacle(instance, Enums.ObstacleType.ORTHACANTHUS, Vector3(2,4,-8))
			pass
		2:
			SpawnObstacle(instance, Enums.ObstacleType.DIPLOCAULUS, Vector3(0,-2.5,0))
			pass
		3:
			SpawnCollectible(instance, Enums.CollectibleType.MEGANEURA, Vector3(1.8,8,4))
			instance.ShowDimetrodon()
			pass
		4:
			SpawnCollectible(instance, Enums.CollectibleType.MAMAYOCARIS, Vector3(0,2,4))
			SpawnCollectible(instance, Enums.CollectibleType.MAMAYOCARIS, Vector3(2,1,0))
			SpawnCollectible(instance, Enums.CollectibleType.MAMAYOCARIS, Vector3(-2,2,-4))
			pass
		5:
			SpawnCollectible(instance, Enums.CollectibleType.GEROBATRACHUS, Vector3(0,3,4))
			SpawnCollectible(instance, Enums.CollectibleType.GEROBATRACHUS, Vector3(-4,4,0))
			SpawnCollectible(instance, Enums.CollectibleType.GEROBATRACHUS, Vector3(4,5,-4))
			pass
		6:
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
	
