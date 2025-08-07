extends Node3D
class_name RiverChunk

const SPEED = 5

# runtime variables
@onready var is_active: bool = true
@onready var dimetrodon_sprite_3d = $Dimetrodon/DimetrodonSprite3D

func _ready():
	dimetrodon_sprite_3d.visible = false

func _process(delta):
	position += Vector3 (0, 0, SPEED * delta)
	if position.z >= 10 and is_active:
		SignalManager.NewRiverChunk.emit(Vector3(0,0,-30))
		is_active = false
	if !is_active:
		await get_tree().create_timer(0.05).timeout
		queue_free()

func ShowDimetrodon():
	dimetrodon_sprite_3d.visible = true
