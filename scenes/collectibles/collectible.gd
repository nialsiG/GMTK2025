extends Area3D
class_name Collectible

@export_group("Collectible characteristics")
@export var collectible_type: Enums.CollectibleType
@export var collectible_points: int = 1

func _on_body_entered(body):
	SignalManager.AddPoints.emit(collectible_points)
	match collectible_type:
		Enums.CollectibleType.GEROBATRACHUS:
			SignalManager.UnlockGerobatrachus.emit()
		Enums.CollectibleType.GNATHORHIZA:
			SignalManager.UnlockGnathorhiza.emit()
		Enums.CollectibleType.MEGANEURA:
			SignalManager.UnlockMeganeura.emit()
		Enums.CollectibleType.PALAENODONTA:
			SignalManager.UnlockPalaenodonta.emit()
	
	await get_tree().create_timer(0.05).timeout
	queue_free()
