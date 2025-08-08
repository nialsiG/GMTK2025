extends Node

@export_group("Sounds")
@export var surface_ambiance_sound: AudioStreamOggVorbis
@export var underwater_ambiance_sound: AudioStreamOggVorbis
@export var dimetrodon_sound: AudioStreamOggVorbis
@export var diplocaulus_sound: AudioStreamOggVorbis
@export var orthacanthus_sound: AudioStreamOggVorbis
@export var gerobatrachus_sound: AudioStreamOggVorbis
@export var insect_sound: AudioStreamOggVorbis

@onready var sfx_audio_stream_player: AudioStreamPlayer = %SFXAudioStreamPlayer
@onready var ambient_audio_stream_player: AudioStreamPlayer = %AmbientAudioStreamPlayer

func _ready():
	SignalManager.UnlockDimetrodon.connect(PlayDimetrodon)
	SignalManager.UnlockDiplocaulus.connect(PlayDiplocaulus)
	SignalManager.UnlockOrthacanthus.connect(PlayOrthacanthus)
	SignalManager.UnlockGerobatrachus.connect(PlayGerobatrachus)
	#SignalManager.UnlockGnathorhiza.connect(PlayGnathorhiza)
	SignalManager.UnlockMeganeura.connect(PlayMeganeura)
	SignalManager.UnlockMamayocaris.connect(PlayMamayocaris)
	SignalManager.PlayerAtSurface.connect(PlaySurfaceAmbiance)
	SignalManager.PlayerDive.connect(PlayUnderwaterAmbiance)

func PlayAmbience(stream: AudioStreamOggVorbis):
	ambient_audio_stream_player.stream = stream
	ambient_audio_stream_player.play()

func PlaySurfaceAmbiance():
	PlayAmbience(surface_ambiance_sound)

func PlayUnderwaterAmbiance():
	PlayAmbience(underwater_ambiance_sound)

func PlaySound(stream: AudioStreamOggVorbis):
	sfx_audio_stream_player.stream = stream
	sfx_audio_stream_player.play()

func PlayDimetrodon():
	PlaySound(dimetrodon_sound)

func PlayDiplocaulus():
	PlaySound(diplocaulus_sound)

func PlayOrthacanthus():
	PlaySound(orthacanthus_sound)

func PlayGerobatrachus():
	PlaySound(gerobatrachus_sound)

func PlayMeganeura():
	PlaySound(insect_sound)

func PlayMamayocaris():
	PlaySound(insect_sound)
