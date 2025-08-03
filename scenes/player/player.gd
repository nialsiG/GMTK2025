extends CharacterBody3D

enum PlayerState { 
	SWIMMING, 
	SURFACE, 
	BED }

const SPEED = 5.0
const JUMP_VELOCITY = 7
const UPPER_LIMIT = 8

@onready var player_state: PlayerState = PlayerState.SWIMMING 
@onready var animated_head: AnimatedSprite3D = $AnimatedHead
@onready var animated_head_timer: Timer = $AnimatedHead/Timer

var play_sand_particles: bool = false

func _ready():
	GlobalVariables.player_global_position = global_position

func _physics_process(delta):
	# state machine
	match player_state:
		PlayerState.SWIMMING:
			if position.y >= UPPER_LIMIT:
				velocity.y = 0
				player_state = PlayerState.SURFACE
				# play surface splash sound
		PlayerState.SURFACE:
			# change sound
			SignalManager.PlayerAtSurface.emit()
			if position.y < UPPER_LIMIT:
				player_state = PlayerState.SWIMMING
			if is_on_floor():
				player_state = PlayerState.BED
				play_sand_particles = true
		PlayerState.BED:
			if !is_on_floor():
				player_state = PlayerState.SWIMMING
				play_sand_particles = false
	
	# Add the gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
		if (velocity.y * -1) > SPEED / 2:
			velocity.y = - SPEED / 2

	# Handle jump
	if Input.is_action_just_pressed("ui_up") and player_state != PlayerState.SURFACE:
		velocity.y = JUMP_VELOCITY
		animated_head.play("going_up")
		if animated_head_timer.is_stopped():
			animated_head_timer.start()
		else:
			animated_head_timer.wait_time = 0.5
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if input_dir.y > 0:
		input_dir.y = 0
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	if play_sand_particles:
		# TODO particles
		pass


func _on_timer_timeout():
	animated_head.play("default")
	animated_head_timer.stop()
