extends Node

@onready var empty_prefab = load("res://scenes/procedural_generation/river_chunk.tscn")

func _ready():
	BuildNewChunk(Vector3(0,0,0))
	BuildNewChunk(Vector3(0,0,-5))
	BuildNewChunk(Vector3(0,0,-10))
	BuildNewChunk(Vector3(0,0,-15))
	SignalManager.NewRiverChunk.connect(BuildNewChunk)

func BuildNewChunk(origin: Vector3):
	var instance: RiverChunk = empty_prefab.instantiate()
	instance.position = origin
	add_child(instance)
