extends Sprite3D
class_name Segment

@onready var swim_direction = -0.1
@onready var swimming = false
@onready var timer: Timer = $Timer

func _on_timer_timeout():
	swim_direction *= -1

func StartTimer():
	timer.start(1)
