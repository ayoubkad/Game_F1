extends Node3D
class_name ThirdPersonCamera

## Third-person camera controller that smoothly follows the player
## Provides smooth camera movement and rotation around the target

# Camera settings
const FOLLOW_SPEED = 5.0
const ROTATION_SPEED = 3.0
const MIN_ZOOM = 3.0
const MAX_ZOOM = 10.0
const HEIGHT_OFFSET = 2.0

# Current camera distance and angle
var current_distance = 5.0
var current_angle = 0.0
var mouse_sensitivity = 0.002

# Reference to the player
@onready var player = get_node("../Player")
@onready var camera = $Camera3D

func _ready():
	"""Initialize the camera controller"""
	print("Camera controller initialized")
	# Set initial position
	if player:
		global_position = player.global_position + Vector3(0, HEIGHT_OFFSET, current_distance)
		look_at(player.global_position + Vector3.UP, Vector3.UP)

func _input(event):
	"""Handle mouse input for camera rotation"""
	if event is InputEventMouseMotion:
		# Rotate camera around player based on mouse movement
		current_angle -= event.relative.x * mouse_sensitivity
		
		# Update camera position based on new angle
		update_camera_position()

func _process(delta):
	"""Update camera position every frame"""
	if not player:
		return
		
	# Smoothly follow the player
	var target_position = calculate_target_position()
	global_position = global_position.lerp(target_position, FOLLOW_SPEED * delta)
	
	# Always look at the player
	var target_look_position = player.global_position + Vector3(0, 1, 0)  # Look at player's center
	var current_look_direction = (target_look_position - global_position).normalized()
	var target_transform = global_transform.looking_at(target_look_position, Vector3.UP)
	global_transform = global_transform.interpolate_with(target_transform, ROTATION_SPEED * delta)

func calculate_target_position():
	"""Calculate the ideal camera position behind the player"""
	var player_position = player.global_position
	
	# Calculate position behind and above the player
	var offset = Vector3(
		sin(current_angle) * current_distance,
		HEIGHT_OFFSET,
		cos(current_angle) * current_distance
	)
	
	return player_position + offset

func update_camera_position():
	"""Update camera position immediately based on current angle"""
	if player:
		global_position = calculate_target_position()

func _unhandled_input(event):
	"""Handle additional camera controls"""
	# Zoom in/out with mouse wheel
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			current_distance = max(MIN_ZOOM, current_distance - 0.5)
			update_camera_position()
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			current_distance = min(MAX_ZOOM, current_distance + 0.5)
			update_camera_position()