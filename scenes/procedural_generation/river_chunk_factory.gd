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
		
	var index: int
	if GlobalVariables.is_chill_mode:
		index = randi_range(0, 5)
	else:
		index = randi_range(0, 16)
		
	match index:
		0:
			# Empty
			instance.ShowDimetrodon()
		1:
			# Free Gerobatrachus!
			SpawnCollectible(instance, Enums.CollectibleType.GEROBATRACHUS, Vector3(randf_range(-4.0, 4.0),randf_range(-1.0, 2.0),4))
			SpawnCollectible(instance, Enums.CollectibleType.GEROBATRACHUS, Vector3(randf_range(-4.0, 4.0),randf_range(2.0, 4.0),0))
			SpawnCollectible(instance, Enums.CollectibleType.GEROBATRACHUS, Vector3(randf_range(-4.0, 4.0),randf_range(2.0, 4.0),0))
			SpawnCollectible(instance, Enums.CollectibleType.GEROBATRACHUS, Vector3(randf_range(-4.0, 4.0),randf_range(-1.0, 2.0),-4))
		2:
			# Free Meganeura!
			SpawnCollectible(instance, Enums.CollectibleType.MEGANEURA, Vector3(randf_range(-2.0, 2.0),8,4))
			SpawnCollectible(instance, Enums.CollectibleType.MEGANEURA, Vector3(randf_range(-2.0, 2.0),8,-4))
		3:
			# Free Mamayocaris!
			SpawnCollectible(instance, Enums.CollectibleType.MAMAYOCARIS, Vector3(randf_range(0, 4.0),randf_range(-4.0, 1.0),0.2))
			SpawnCollectible(instance, Enums.CollectibleType.MAMAYOCARIS, Vector3(randf_range(0, 4.0),randf_range(-4.0, 1.0),0.1))
			SpawnCollectible(instance, Enums.CollectibleType.MAMAYOCARIS, Vector3(randf_range(0, 4.0),randf_range(-4.0, 1.0),0))
			SpawnCollectible(instance, Enums.CollectibleType.MAMAYOCARIS, Vector3(randf_range(0, 4.0),randf_range(-4.0, 1.0),-0.1))
			SpawnCollectible(instance, Enums.CollectibleType.MAMAYOCARIS, Vector3(randf_range(0, 4.0),randf_range(-4.0, 1.0),-0.2))
			SpawnCollectible(instance, Enums.CollectibleType.MAMAYOCARIS, Vector3(randf_range(0, 4.0),randf_range(-4.0, 1.0),-0.3))
		4:
			# High water mix 
			SpawnCollectible(instance, Enums.CollectibleType.GEROBATRACHUS, Vector3(randf_range(-4.0, 4.0),randf_range(2.0, 4.0),4))
			SpawnCollectible(instance, Enums.CollectibleType.GEROBATRACHUS, Vector3(randf_range(-4.0, 4.0),randf_range(2.0, 4.0),0))
			SpawnCollectible(instance, Enums.CollectibleType.MEGANEURA, Vector3(randf_range(-2.0, 2.0),8,-4))
		5:
			# Deep water mix
			SpawnCollectible(instance, Enums.CollectibleType.GEROBATRACHUS, Vector3(randf_range(-4.0, 4.0),randf_range(1.0, 3.0),4))
			SpawnCollectible(instance, Enums.CollectibleType.GEROBATRACHUS, Vector3(randf_range(-4.0, 4.0),randf_range(1.0, 3.0),4))
			SpawnCollectible(instance, Enums.CollectibleType.MAMAYOCARIS, Vector3(randf_range(0, 4.0),randf_range(-4.0, 1.0),0.1))
			SpawnCollectible(instance, Enums.CollectibleType.MAMAYOCARIS, Vector3(randf_range(0, 4.0),randf_range(-4.0, 1.0),0))
			SpawnCollectible(instance, Enums.CollectibleType.MAMAYOCARIS, Vector3(randf_range(0, 4.0),randf_range(-4.0, 1.0),-0.1))
		6:
			# High frog crossfire
			SpawnObstacle(instance, Enums.ObstacleType.DIMETRODON, Vector3(randf_range(-1.5, 1.5),8,4))
			SpawnCollectible(instance, Enums.CollectibleType.GEROBATRACHUS, Vector3(randf_range(-4.0, 4.0),4,1))
			SpawnObstacle(instance, Enums.ObstacleType.DIPLOCAULUS, Vector3(0,-2.5,0))
		7:
			# Low frog crossfire
			SpawnCollectible(instance, Enums.CollectibleType.GEROBATRACHUS, Vector3(randf_range(-4.0, 4.0),0,4))
			SpawnObstacle(instance, Enums.ObstacleType.DIPLOCAULUS, Vector3(0,-2.5,0))
			SpawnObstacle(instance, Enums.ObstacleType.DIMETRODON, Vector3(randf_range(-1.5, 1.5),8,-4))
		8:
			# Middle frog crossfire
			SpawnObstacle(instance, Enums.ObstacleType.DIMETRODON, Vector3(randf_range(-1.5, 1.5),8,4))
			SpawnCollectible(instance, Enums.CollectibleType.GEROBATRACHUS, Vector3(randf_range(-4.0, 4.0),4,1))
			SpawnObstacle(instance, Enums.ObstacleType.ORTHACANTHUS, Vector3(randf_range(-4.0, 4.0),2,-8))
			SpawnObstacle(instance, Enums.ObstacleType.DIPLOCAULUS, Vector3(0,-2.5,0))
		9:
			# Jaws!
			SpawnObstacle(instance, Enums.ObstacleType.ORTHACANTHUS, Vector3(randf_range(-4.0, 4.0),5,0))
			SpawnObstacle(instance, Enums.ObstacleType.ORTHACANTHUS, Vector3(randf_range(-4.0, 4.0),2,-4))
			SpawnObstacle(instance, Enums.ObstacleType.DIPLOCAULUS, Vector3(0,-2.5,0))
		10:
			# Griffinfly trap
			SpawnCollectible(instance, Enums.CollectibleType.MEGANEURA, Vector3(2,8,4))
			SpawnCollectible(instance, Enums.CollectibleType.MEGANEURA, Vector3(-3,8,2))
			SpawnObstacle(instance, Enums.ObstacleType.ORTHACANTHUS, Vector3(randf_range(-4.0, 4.0),7.5,-30))
			SpawnObstacle(instance, Enums.ObstacleType.DIPLOCAULUS, Vector3(0,-2.5,0))
		11:
			# Mamayocaris_trap
			SpawnCollectible(instance, Enums.CollectibleType.MAMAYOCARIS, Vector3(randf_range(0, 4.0),randf_range(-4.0, 1.0),0.2))
			SpawnCollectible(instance, Enums.CollectibleType.MAMAYOCARIS, Vector3(randf_range(0, 4.0),randf_range(-4.0, 1.0),0.1))
			SpawnCollectible(instance, Enums.CollectibleType.MAMAYOCARIS, Vector3(randf_range(0, 4.0),randf_range(-4.0, 1.0),0))
			SpawnCollectible(instance, Enums.CollectibleType.MAMAYOCARIS, Vector3(randf_range(0, 4.0),randf_range(-4.0, 1.0),-0.1))
			SpawnCollectible(instance, Enums.CollectibleType.MAMAYOCARIS, Vector3(randf_range(0, 4.0),randf_range(-4.0, 1.0),-0.2))
			SpawnObstacle(instance, Enums.ObstacleType.ORTHACANTHUS, Vector3(randf_range(-4.0, 4.0),7.5,-30))
			SpawnObstacle(instance, Enums.ObstacleType.DIPLOCAULUS, Vector3(0,-2.5,-4))
		12:
			# Dimetrodon and griffinfly
			SpawnCollectible(instance, Enums.CollectibleType.MEGANEURA, Vector3(randf_range(-2.0, 2.0),8,4))
			SpawnObstacle(instance, Enums.ObstacleType.DIMETRODON, Vector3(-2.5,8,-4))
			# Diplocaulus and frog
			SpawnCollectible(instance, Enums.CollectibleType.GEROBATRACHUS, Vector3(randf_range(-4.0, 4.0),randf_range(-2.0, 2.0),0))
			SpawnObstacle(instance, Enums.ObstacleType.DIPLOCAULUS, Vector3(0,-2.5,-4))
		13:
			# Shark and mamayocaris
			SpawnCollectible(instance, Enums.CollectibleType.MAMAYOCARIS, Vector3(randf_range(0, 4.0),randf_range(-4.0, 1.0),0.2))
			SpawnCollectible(instance, Enums.CollectibleType.MAMAYOCARIS, Vector3(randf_range(0, 4.0),randf_range(-4.0, 1.0),0.1))
			SpawnCollectible(instance, Enums.CollectibleType.MAMAYOCARIS, Vector3(randf_range(0, 4.0),randf_range(-4.0, 1.0),0))
			SpawnCollectible(instance, Enums.CollectibleType.MAMAYOCARIS, Vector3(randf_range(0, 4.0),randf_range(-4.0, 1.0),-0.1))
			SpawnCollectible(instance, Enums.CollectibleType.MAMAYOCARIS, Vector3(randf_range(0, 4.0),randf_range(-4.0, 1.0),-0.2))
			SpawnObstacle(instance, Enums.ObstacleType.ORTHACANTHUS, Vector3(randf_range(-4.0, 4.0),2,-20))
		14:
			# Shark and frogs
			SpawnCollectible(instance, Enums.CollectibleType.GEROBATRACHUS, Vector3(randf_range(-4.0, 4.0),randf_range(2.0, 4.0),4))
			SpawnCollectible(instance, Enums.CollectibleType.GEROBATRACHUS, Vector3(randf_range(-4.0, 4.0),randf_range(2.0, 4.0),4))
			SpawnCollectible(instance, Enums.CollectibleType.GEROBATRACHUS, Vector3(randf_range(-4.0, 4.0),randf_range(2.0, 4.0),4))
			SpawnObstacle(instance, Enums.ObstacleType.ORTHACANTHUS, Vector3(randf_range(-4.0, 4.0),4.0,-8))
		15:
			# Frog / High shark and Diplocaulus / Frog
			SpawnCollectible(instance, Enums.CollectibleType.GEROBATRACHUS, Vector3(randf_range(-4.0, 2.0),randf_range(1.0, 3.0),4))
			SpawnObstacle(instance, Enums.ObstacleType.DIPLOCAULUS, Vector3(0,-2.5,0))
			SpawnCollectible(instance, Enums.CollectibleType.GEROBATRACHUS, Vector3(randf_range(-4.0, 2.0),randf_range(1.0, 3.0),-4))
			SpawnObstacle(instance, Enums.ObstacleType.ORTHACANTHUS, Vector3(randf_range(-4.0, 4.0),6,-26))
		16:
			# Frog / Diplocaulus / Shark / Griffinfly
			SpawnCollectible(instance, Enums.CollectibleType.GEROBATRACHUS, Vector3(randf_range(-4.0, 2.0),randf_range(1.0, 3.0),4))
			SpawnObstacle(instance, Enums.ObstacleType.DIPLOCAULUS, Vector3(0,-2.5,0))
			SpawnCollectible(instance, Enums.CollectibleType.MEGANEURA, Vector3(randf_range(-2.0, 2.0),8,4))
			SpawnObstacle(instance, Enums.ObstacleType.ORTHACANTHUS, Vector3(randf_range(-4.0, 4.0),7,-26))
