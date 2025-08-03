extends Node

@onready var start_menu = %StartMenu
@onready var options_menu = %OptionsMenu
@onready var info_screen = %InfoScreen
@onready var menu_camera = %Menu_Camera
@onready var player = %Player
@onready var menu_camera_3d: Camera3D = $"3C/Menu_Camera/Camera3D"
@onready var player_camera_3d: Camera3D = $"3C/Player/Camera3D"
@onready var score_label: Label = %ScoreLabel
@onready var max_score_label: Label = %MaxScoreLabel

@onready var current_score: int = 0 
@onready var max_score: int = 0

func _unhandled_input(event):
	if event is InputEventKey and start_menu.visible and !options_menu.visible:
		StartGame()

func _ready():
	StartMenu()
	SignalManager.GameOver.connect(StartMenu)
	SignalManager.AddPoints.connect(UpdateScore)

func StartGame():
	start_menu.visible = false
	menu_camera.visible = false
	player_camera_3d.make_current()
	player.visible = true
	GlobalVariables.can_spawn = true
	current_score = 0
	UpdateScore()

func StartMenu():
	start_menu.visible = true
	menu_camera.visible = true
	menu_camera_3d.make_current()
	player.visible = false
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
	info_screen.visible = !info_screen.visible
	get_tree().paused = info_screen.visible
