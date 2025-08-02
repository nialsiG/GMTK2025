extends Node

@onready var start_menu = %StartMenu
@onready var options_menu = %OptionsMenu
@onready var info_screen = %InfoScreen
@onready var menu_camera = %Menu_Camera
@onready var player = %Player
@onready var menu_camera_3d: Camera3D = $"3C/Menu_Camera/Camera3D"
@onready var player_camera_3d: Camera3D = $"3C/Player/Camera3D"

func _unhandled_input(event):
	if event is InputEventKey and start_menu.visible and !options_menu.visible:
		StartGame()

func _ready():
	StartMenu()
	SignalManager.GameOver.connect(StartMenu)

func StartGame():
	start_menu.visible = false
	menu_camera.visible = false
	player_camera_3d.make_current()
	player.visible = true

func StartMenu():
	start_menu.visible = true
	menu_camera.visible = true
	menu_camera_3d.make_current()
	player.visible = false

func _on_options_button_pressed():
	options_menu.visible = !options_menu.visible
