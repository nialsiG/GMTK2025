extends Area3D
class_name Obstacle

# runtime variables
@export var obstacle_type: Enums.ObstacleType

func _on_body_entered(body):
	SignalManager.GameOver.emit()
	match obstacle_type:
		Enums.ObstacleType.DIMETRODON:
			SignalManager.UnlockDimetrodon.emit()
