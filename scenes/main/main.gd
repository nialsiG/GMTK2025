extends Node

@onready var start_menu = %StartMenu
@onready var options_menu = %OptionsMenu
@onready var info_screen = %InfoScreen
@onready var menu_camera = %Menu_Camera
@onready var player = %Player
@onready var body_nodes = $"3C/BodyNodes"
@onready var menu_camera_3d: Camera3D = $"3C/Menu_Camera/Camera3D"
@onready var player_camera_3d: Camera3D = $"3C/Player/Camera3D"
@onready var score_label: Label = %ScoreLabel
@onready var max_score_label: Label = %MaxScoreLabel
@onready var info_screen_button: TextureButton = $CanvasLayer/InfoScreenButton

@onready var current_score: int = 0 
@onready var max_score: int = 0

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

func _unhandled_input(event):
	if event is InputEventKey and start_menu.visible and !options_menu.visible:
		StartGame()

func _ready():
	StartMenu()
	SignalManager.GameOver.connect(StartMenu)
	SignalManager.AddPoints.connect(UpdateScore)
	SignalManager.UnlockDimetrodon.connect(UnlockDimetrodon)
	SignalManager.UnlockDiplocaulus.connect(UnlockDiplocaulus)
	SignalManager.UnlockOrthacanthus.connect(UnlockOrthacanthus)
	SignalManager.UnlockGerobatrachus.connect(UnlockGerobatrachus)
	SignalManager.UnlockGnathorhiza.connect(UnlockGnathorhiza)
	SignalManager.UnlockMeganeura.connect(UnlockMeganeura)
	SignalManager.UnlockMamayocaris.connect(UnlockMamayocaris)

func _process(delta):
	if is_button_active:
		glow_power += delta * glow_speed
		if glow_power >= 2.0 and glow_speed > 0 or glow_power <= 1.0 and glow_speed < 0:
			glow_speed *= -1.0
		info_screen_button.material.set_shader_parameter("glow_power", glow_power)

func StartGame():
	start_menu.visible = false
	menu_camera.visible = false
	player_camera_3d.make_current()
	player.visible = true
	body_nodes.visible = true
	GlobalVariables.can_spawn = true
	current_score = 0
	UpdateScore()

func StartMenu():
	start_menu.visible = true
	menu_camera.visible = true
	menu_camera_3d.make_current()
	player.visible = false
	body_nodes.visible = false
	GlobalVariables.can_spawn = false
	UpdateScore()

func UpdateScore(amount: int = 0):
	current_score += amount
	print("current score: ", current_score)
	score_label.text = str(current_score)
	if current_score >= max_score:
		max_score_label.text = str(current_score)
		max_score = current_score

func _on_options_button_pressed():
	options_menu.visible = !options_menu.visible

func _on_info_screen_button_pressed():
	if is_button_active:
		is_button_active = false
		info_screen_button.material.set_shader_parameter("glow_power", 0)
		
	info_screen.visible = !info_screen.visible
	get_tree().paused = info_screen.visible

func UnlockDimetrodon():
	if dimetrodon_unlocked:
		return
	is_button_active = true
	dimetrodon_unlocked = true
	# add Dimetrodon to wiki

func UnlockOrthacanthus():
	if orthacanthus_unlocked:
		return
	is_button_active = true
	orthacanthus_unlocked = true
	# add Orthocanthus to wiki

func UnlockDiplocaulus():
	if diplocaulus_unlocked:
		return
	is_button_active = true
	diplocaulus_unlocked = true
	# add Diplocaulus to wiki

func UnlockGerobatrachus():
	if gerobatrachus_unlocked:
		return
	is_button_active = true
	gerobatrachus_unlocked = true
	# add Gerobatrachus to wiki

func UnlockGnathorhiza():
	if gnathorhiza_unlocked:
		return
	is_button_active = true
	gnathorhiza_unlocked = true
	# add Gnathorhiza to wiki

func UnlockMeganeura():
	if meganeura_unlocked:
		return
	is_button_active = true
	meganeura_unlocked = true
	# add Meganeura to wiki

func UnlockMamayocaris():
	if mamayocaris_unlocked:
		return
	is_button_active = true
	mamayocaris_unlocked = true
	# add Mamayocaris to wiki
