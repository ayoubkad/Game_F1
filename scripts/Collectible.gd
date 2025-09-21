extends RigidBody3D
class_name Collectible

## Collectible object that rotates and can be collected by the player
## Disappears when the player touches it

# Rotation speed for the collectible animation
const ROTATION_SPEED = 2.0
const FLOAT_AMPLITUDE = 0.3
const FLOAT_SPEED = 1.5

# Original position for floating animation
var original_position: Vector3
var time_passed: float = 0.0

# Reference to the area detection
@onready var area_3d = $Area3D

func _ready():
	"""Initialize the collectible"""
	print("Collectible initialized at: ", global_position)
	original_position = global_position
	
	# Connect the area entered signal to detect player collision
	if area_3d:
		area_3d.body_entered.connect(_on_body_entered)
	
	# Make the collectible look nice with a golden color
	var mesh_instance = $MeshInstance3D
	if mesh_instance and mesh_instance.mesh:
		# Create a simple material for the collectible
		var material = StandardMaterial3D.new()
		material.albedo_color = Color.GOLD
		material.metallic = 0.8
		material.roughness = 0.2
		material.emission_enabled = true
		material.emission = Color.GOLD * 0.3
		mesh_instance.material_override = material

func _process(delta):
	"""Handle rotation and floating animation"""
	time_passed += delta
	
	# Rotate the collectible around Y-axis
	rotate_y(ROTATION_SPEED * delta)
	
	# Add floating motion up and down
	var float_offset = sin(time_passed * FLOAT_SPEED) * FLOAT_AMPLITUDE
	global_position.y = original_position.y + float_offset

func _on_body_entered(body):
	"""Called when something enters the collectible's detection area"""
	print("Body entered collectible area: ", body.name)
	
	# Check if it's the player
	if body is Player:
		collect()

func collect():
	"""Handle collection of this item"""
	print("Collectible collected!")
	
	# Create a simple collection effect
	create_collection_effect()
	
	# Remove the collectible from the scene
	queue_free()

func create_collection_effect():
	"""Create a simple visual effect when collected"""
	# Create a temporary sparkle effect
	var tween = create_tween()
	
	# Scale up briefly then disappear
	tween.parallel().tween_property(self, "scale", Vector3(1.5, 1.5, 1.5), 0.2)
	tween.parallel().tween_property(self, "modulate", Color.TRANSPARENT, 0.2)
	
	# Optional: Add a sound effect here in the future
	print("✨ Sparkle effect played!")

func _on_area_3d_body_entered(body):
	"""Alternative signal connection method"""
	_on_body_entered(body)