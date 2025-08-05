extends Node3D

const SPEED = 5

# node
@onready var animated_sprite: AnimatedSprite3D = $"../AnimatedSprite3D"

# runtime variables
var parent: Obstacle

func _ready():
	parent = get_parent() as Obstacle
	animated_sprite.play("default", 0.5)

func _physics_process(delta):
	parent.position += delta * SPEED * Vector3(0, 0, 1)
	animated_sprite.material_override.albedo_texture = animated_sprite.sprite_frames.get_frame_texture("default", animated_sprite.get_frame())
