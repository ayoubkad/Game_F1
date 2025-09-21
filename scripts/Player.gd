extends CharacterBody3D
class_name Player

## Player controller script for 3D movement with physics
## Handles WASD movement and Space jumping with smooth physics

# Movement constants
const SPEED = 5.0
const JUMP_VELOCITY = 8.0
const ACCELERATION = 10.0
const FRICTION = 10.0

# Get the gravity from the project settings to be synced with RigidBody nodes
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# Reference to the camera controller for movement direction
@onready var camera_controller = get_node("../CameraController")

func _ready():
	"""Initialize the player"""
	print("Player initialized")

func _physics_process(delta):
	"""Handle physics-based movement and input every frame"""
	handle_gravity(delta)
	handle_jump()
	handle_movement(delta)
	
	# Apply movement
	move_and_slide()

func handle_gravity(delta):
	"""Apply gravity when not on the floor"""
	if not is_on_floor():
		velocity.y -= gravity * delta

func handle_jump():
	"""Handle jump input when on the floor"""
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		print("Player jumped!")

func handle_movement(delta):
	"""Handle horizontal movement based on camera direction"""
	# Get input direction
	var input_dir = Vector2.ZERO
	if Input.is_action_pressed("move_left"):
		input_dir.x -= 1
	if Input.is_action_pressed("move_right"):
		input_dir.x += 1
	if Input.is_action_pressed("move_forward"):
		input_dir.y -= 1
	if Input.is_action_pressed("move_backward"):
		input_dir.y += 1
	
	# Normalize input to prevent faster diagonal movement
	if input_dir.length() > 1.0:
		input_dir = input_dir.normalized()
	
	# Calculate movement direction based on camera orientation
	var direction = Vector3.ZERO
	if camera_controller:
		# Get camera forward and right vectors
		var camera_transform = camera_controller.global_transform
		var forward = -camera_transform.basis.z
		var right = camera_transform.basis.x
		
		# Flatten vectors to horizontal plane
		forward.y = 0
		right.y = 0
		forward = forward.normalized()
		right = right.normalized()
		
		# Calculate movement direction
		direction = (right * input_dir.x + forward * input_dir.y).normalized()
	
	# Apply movement with acceleration/friction
	if direction != Vector3.ZERO:
		# Accelerate towards target velocity
		var target_velocity = direction * SPEED
		velocity.x = move_toward(velocity.x, target_velocity.x, ACCELERATION * delta)
		velocity.z = move_toward(velocity.z, target_velocity.z, ACCELERATION * delta)
	else:
		# Apply friction when no input
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
		velocity.z = move_toward(velocity.z, 0, FRICTION * delta)

func _on_collectible_collected():
	"""Called when a collectible is collected"""
	print("Collectible collected by player!")
