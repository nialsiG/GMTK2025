extends Node

var can_spawn: bool
var player_global_position: Vector3
var global_volume: float = 1
var random: float = 1

func TrueRandom():
	random = abs(random - randf_range(0.0, 1.0))
	return random
