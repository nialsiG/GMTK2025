extends Node3D

const SPEED = 0.5

# nodes
@onready var sprite_3d = $"../Sprite3D"
@onready var collision_polygon_3d = $"../CollisionPolygon3D"
@onready var parent: Obstacle = $".."

func _ready():
	if parent.global_position.x < 0.0:
		FlipSprite()

func _physics_process(delta):
	parent.position -= delta * SPEED * Vector3(sprite_3d.scale.x, 0, 0)

func FlipSprite():
	sprite_3d.scale.x *= -1.0
	collision_polygon_3d.scale.x *= -1.0
