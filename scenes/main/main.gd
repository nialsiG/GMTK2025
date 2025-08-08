extends Node

@onready var start_menu: Control = %StartMenu
@onready var options_menu: Control = %OptionsMenu
@onready var info_screen: Control = %InfoScreen
@onready var menu_camera: Node3D = %Menu_Camera
@onready var player: CharacterBody3D = %Player
@onready var body_nodes: Node3D = $"3C/BodyNodes"
@onready var menu_camera_3d: Camera3D = $"3C/Menu_Camera/Camera3D"
@onready var player_camera_3d: Camera3D = $"3C/Player/Camera3D"
@onready var score_label: Label = %ScoreLabel
@onready var max_score_label: Label = %MaxScoreLabel
@onready var info_screen_button: TextureButton = $CanvasLayer/InfoScreenButton
@onready var contrast_slider: HSlider = %ContrastSlider
@onready var brightness_slider: HSlider = %BrightnessSlider
@onready var music_slider: HSlider = %MusicSlider
@onready var sfx_slider: HSlider = %SFXSlider
@onready var master_volume_slider: HSlider = %MasterVolumeSlider
@onready var world_environment: WorldEnvironment = $WorldEnvironment
@onready var music_audio_stream_player: AudioStreamPlayer = $MusicAudioStreamPlayer
@onready var gerobatrachus_button: Button = %GerobatrachusButton
@onready var dimetrodon_button: Button = %DimetrodonButton
@onready var orthacanthus_button: Button = %OrthacanthusButton
@onready var diplocaulus_button: Button = %DiplocaulusButton
@onready var mamayocaris_button: Button = %MamayocarisButton
@onready var meganeura_button: Button = %MeganeuraButton
@onready var gnathorhiza_button: Button = %GnathorhizaButton
@onready var back_to_menu_button: Button = $CanvasLayer/BackToMenuButton
@onready var v_box_info_button_container: VBoxContainer = %VBoxInfoButtonContainer
@onready var instructions: Control = %Instructions
@onready var instructions_label: Label = %InstructionsLabel

@onready var current_score: int = 0 
@onready var max_score: int = 0

@onready var can_start: bool = true

# inform menu booleans
var dimetrodon_unlocked: bool = false
var orthacanthus_unlocked: bool = false
var diplocaulus_unlocked: bool = false
var meganeura_unlocked: bool = false
var gerobatrachus_unlocked: bool = false
var gnathorhiza_unlocked: bool = false
var mamayocaris_unlocked: bool = false

# button
var is_button_active: bool = false
var glow_power: float = 1.0
var glow_speed: float = 1.0
var info_button_focus: String

func _unhandled_input(event):
	if Input.is_action_just_pressed("options_menu"):
		CloseOpenOptions()
	elif Input.is_action_just_pressed("info_menu"):
		CloseOpenInfoScreen()
	elif event is InputEvent and start_menu.visible and !options_menu.visible and !info_screen.visible and can_start:
		StartGame()

func _ready():
	StartMenu()
	SetVolume()
	SetBrightness()
	SetContrast()
	for button in v_box_info_button_container.get_children():
		LockButton(button as Button)
	SignalManager.GameOver.connect(StartMenu)
	SignalManager.AddPoints.connect(UpdateScore)
	SignalManager.UnlockDimetrodon.connect(UnlockDimetrodon)
	SignalManager.UnlockDiplocaulus.connect(UnlockDiplocaulus)
	SignalManager.UnlockOrthacanthus.connect(UnlockOrthacanthus)
	SignalManager.UnlockGerobatrachus.connect(UnlockGerobatrachus)
	SignalManager.UnlockGnathorhiza.connect(UnlockGnathorhiza)
	SignalManager.UnlockMeganeura.connect(UnlockMeganeura)
	SignalManager.UnlockMamayocaris.connect(UnlockMamayocaris)
	set_process_shortcut_input(true)

func _process(delta):
	glow_power += delta * glow_speed
	if glow_power >= 2.0 and glow_speed > 0 or glow_power <= 1.0 and glow_speed < 0:
		glow_speed *= -1.0
	instructions_label.material.set_shader_parameter("glow_power", glow_power)
	if is_button_active:
		info_screen_button.material.set_shader_parameter("glow_power", glow_power)

func StartGame():
	start_menu.visible = false
	menu_camera.visible = false
	player_camera_3d.make_current()
	player.visible = true
	body_nodes.visible = true
	back_to_menu_button.visible = true
	GlobalVariables.can_spawn = true
	current_score = 0
	UpdateScore()

func StartMenu():
	can_start = false
	start_menu.visible = true
	menu_camera.visible = true
	menu_camera_3d.make_current()
	player.visible = false
	body_nodes.visible = false
	back_to_menu_button.visible = false
	GlobalVariables.can_spawn = false
	UpdateScore()
	await get_tree().create_timer(0.5).timeout
	can_start = true

func UpdateScore(amount: int = 0):
	current_score += amount
	score_label.text = str(current_score)
	if current_score >= max_score:
		max_score_label.text = str(current_score)
		max_score = current_score

func SetVolume(global_volume: float = master_volume_slider.value, music_volume: float = music_slider.value, sfx_volume: float = sfx_slider.value):
	GlobalVariables.global_volume = global_volume
	music_audio_stream_player.volume_db = GlobalVariables.global_volume * music_volume
	# sfx volume

func SetBrightness(value: float = brightness_slider.value):
	world_environment.environment.adjustment_brightness = value

func SetContrast(value: float = contrast_slider.value):
	world_environment.environment.adjustment_contrast = value

func _on_options_button_pressed():
	CloseOpenOptions()

func CloseOpenOptions():
	can_start = false
	options_menu.visible = !options_menu.visible
	instructions.visible = !options_menu.visible
	await get_tree().create_timer(0.5).timeout
	can_start = true

func _on_info_screen_button_pressed():
	CloseOpenInfoScreen()

func CloseOpenInfoScreen():
	can_start = false
	if is_button_active:
		is_button_active = false
		info_screen_button.material.set_shader_parameter("glow_power", 0)
	info_screen.visible = !info_screen.visible
	if info_button_focus:
		info_screen.ClickOn(info_button_focus)
	get_tree().paused = info_screen.visible
	await get_tree().create_timer(0.5).timeout
	can_start = true

func LockButton(button: Button):
	button.disabled = true
	button.text = str("?")

func UnlockButton(button: Button, text: String):
	button.disabled = false
	button.text = text

func UnlockDimetrodon():
	if dimetrodon_unlocked:
		return
	is_button_active = true
	dimetrodon_unlocked = true
	# add Dimetrodon to wiki
	UnlockButton(dimetrodon_button, "Dimetrodon")
	info_button_focus = "Dimetrodon"

func UnlockOrthacanthus():
	if orthacanthus_unlocked:
		return
	is_button_active = true
	orthacanthus_unlocked = true
	# add Orthocanthus to wiki
	UnlockButton(orthacanthus_button, "Orthacanthus")
	info_button_focus = "Orthacanthus"

func UnlockDiplocaulus():
	if diplocaulus_unlocked:
		return
	is_button_active = true
	diplocaulus_unlocked = true
	# add Diplocaulus to wiki
	UnlockButton(diplocaulus_button, "Diplocaulus")
	info_button_focus = "Diplocaulus"

func UnlockGerobatrachus():
	if gerobatrachus_unlocked:
		return
	is_button_active = true
	gerobatrachus_unlocked = true
	# add Gerobatrachus to wiki
	UnlockButton(gerobatrachus_button, "Gerobatrachus")
	info_button_focus = "Gerobatrachus"

func UnlockGnathorhiza():
	if gnathorhiza_unlocked:
		return
	is_button_active = true
	gnathorhiza_unlocked = true
	# add Gnathorhiza to wiki
	UnlockButton(gnathorhiza_button, "Gnathorhiza")
	info_button_focus = "Gnathorhiza"

func UnlockMeganeura():
	if meganeura_unlocked:
		return
	is_button_active = true
	meganeura_unlocked = true
	# add Meganeura to wiki
	UnlockButton(meganeura_button, "Meganeuropsis")
	info_button_focus = "Meganeuropsis"

func UnlockMamayocaris():
	if mamayocaris_unlocked:
		return
	is_button_active = true
	mamayocaris_unlocked = true
	# add Mamayocaris to wiki
	UnlockButton(mamayocaris_button, "Mamayocaris")
	info_button_focus = "Mamayocaris"

func _on_contrast_slider_value_changed(value):
	SetContrast()

func _on_brightness_slider_value_changed(value):
	SetBrightness()

func _on_master_volume_slider_value_changed(value):
	SetVolume()

func _on_music_slider_value_changed(value):
	SetVolume()

func _on_sfx_slider_value_changed(value):
	SetVolume()

func _on_option_button_toggled(toggled_on):
	GlobalVariables.is_chill_mode = !GlobalVariables.is_chill_mode

func _on_back_to_menu_button_pressed():
	StartMenu()
