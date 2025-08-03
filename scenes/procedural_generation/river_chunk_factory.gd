extends Node

@onready var empty_prefab = load("res://scenes/procedural_generation/river_chunk.tscn")

func _ready():
	BuildNewChunk(Vector3(0,0,0))
	BuildNewChunk(Vector3(0,0,-5))
	BuildNewChunk(Vector3(0,0,-10))
	BuildNewChunk(Vector3(0,0,-15))
	BuildNewChunk(Vector3(0,0,-20))
	BuildNewChunk(Vector3(0,0,-25))
	BuildNewChunk(Vector3(0,0,-30))
	SignalManager.NewRiverChunk.connect(BuildNewChunk)

func BuildNewChunk(origin: Vector3, is_empty = false):
	var instance: RiverChunk = empty_prefab.instantiate()
	instance.position = origin
	add_child(instance)
	if is_empty or !GlobalVariables.can_spawn:
		return
	
	var index = randi_range(0,10)
	match index:
		0:
			instance.SpawnObstacle(Enums.ObstacleType.DIMETRODON, Vector3(0,8,-5))
			pass
		1:
			instance.SpawnObstacle(Enums.ObstacleType.DIMETRODON, Vector3(0,8,-5))
			pass
		2:
			instance.SpawnObstacle(Enums.ObstacleType.DIMETRODON, Vector3(0,8,-5))
			pass
		3:
			instance.SpawnObstacle(Enums.ObstacleType.DIMETRODON, Vector3(0,8,-5))
			pass
		4:
			instance.SpawnObstacle(Enums.ObstacleType.DIMETRODON, Vector3(0,8,-5))
			pass
		5:
			instance.SpawnCollectible(Enums.CollectibleType.GEROBATRACHUS, Vector3(0,4,-5))
			pass
		6:
			instance.SpawnCollectible(Enums.CollectibleType.GEROBATRACHUS, Vector3(0,4,-5))
			pass
		7:
			instance.SpawnCollectible(Enums.CollectibleType.GEROBATRACHUS, Vector3(0,4,-5))
			pass
		8:
			instance.SpawnCollectible(Enums.CollectibleType.GEROBATRACHUS, Vector3(0,4,-5))
			pass
		9:
			instance.SpawnCollectible(Enums.CollectibleType.GEROBATRACHUS, Vector3(0,4,-5))
			pass
		10:
			instance.SpawnCollectible(Enums.CollectibleType.GEROBATRACHUS, Vector3(0,4,-5))
			pass
	
