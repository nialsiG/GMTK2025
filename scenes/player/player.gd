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
			if position.y > UPPER_LIMIT:
				velocity.y = 0
				player_state = PlayerState.SURFACE
				# play surface splash sound
				SignalManager.PlayerAtSurface.emit()
			if is_on_floor():
				player_state = PlayerState.BED
				play_sand_particles = true
		PlayerState.SURFACE:
			# Handle dive
			if Input.is_action_just_pressed("move_down") and player_state == PlayerState.SURFACE:
				velocity.y = -JUMP_VELOCITY
				player_state = PlayerState.SWIMMING
				# play surface splash sound
				SignalManager.PlayerDive.emit()
		PlayerState.BED:
			if !is_on_floor():
				player_state = PlayerState.SWIMMING
				play_sand_particles = false
	
	# Add the gravity
	if player_state == PlayerState.SWIMMING:
		velocity += get_gravity() * delta
		if (velocity.y * -1) > SPEED / 2:
			velocity.y = - SPEED / 2

	# Handle jump
	if Input.is_action_just_pressed("move_up") and player_state != PlayerState.SURFACE:
		velocity.y = JUMP_VELOCITY
		animated_head.play("going_up")
		animated_head.material_override.albedo_texture = animated_head.sprite_frames.get_frame_texture("going_up", 0)
		if animated_head_timer.is_stopped():
			animated_head_timer.start()
		else:
			animated_head_timer.wait_time = 0.5
			
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_axis("move_left", "move_right")
	var direction = (transform.basis * Vector3(input_dir, 0, 0)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	GlobalVariables.player_global_position = global_position
	
	if play_sand_particles:
		# TODO particles
		pass


func _on_timer_timeout():
	animated_head.play("default")
	animated_head.material_override.albedo_texture = animated_head.sprite_frames.get_frame_texture("default", 0)
	animated_head_timer.stop()
