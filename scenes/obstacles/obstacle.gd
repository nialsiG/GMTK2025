extends Area3D
class_name Obstacle

@export_group("Obstacle characteristics")
@export var obstacle_type: Enums.ObstacleType
@export var obstacle_points: int = 1

# runtime variables
@onready var is_passed: bool = false

func _physics_process(_delta):
	if !is_passed and global_position.z > GlobalVariables.player_global_position.z:
		print("obstacle has been passed!")
		is_passed = true
		SignalManager.AddPoints.emit(obstacle_points)

func _on_body_entered(body):
	SignalManager.GameOver.emit()
	match obstacle_type:
		Enums.ObstacleType.DIMETRODON:
			SignalManager.UnlockDimetrodon.emit()
		Enums.ObstacleType.DIPLOCAULUS:
			SignalManager.UnlockDiplocaulus.emit()
		Enums.ObstacleType.ORTHACANTHUS:
			SignalManager.UnlockOrthacanthus.emit()
