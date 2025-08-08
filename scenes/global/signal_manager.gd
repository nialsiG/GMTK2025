extends Node

# Gameplay events
signal GameOver
signal AddPoints(amount: int)
signal PlayerAtSurface
signal PlayerDive

# Spawn elements
signal NewRiverChunk(origin: Vector3)

# Unlockables
signal UnlockDimetrodon
signal UnlockDiplocaulus
signal UnlockOrthacanthus
signal UnlockGerobatrachus
signal UnlockGnathorhiza
signal UnlockMeganeura
signal UnlockMamayocaris
