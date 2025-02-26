class_name MovementController
extends CharacterBody3D

@export_range(0.0, 1.0, 0.05) var air_control := 0.3

@export var gravity_multiplier := 3.0
@export var speed := 10
@export var acceleration := 8
@export var deceleration := 10
@export var jump_height := 10

var direction := Vector3()
var input_axis := Vector2()

# Get the gravity from the project settings to be synced with RigidDynamicBody nodes.
@onready
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity") * gravity_multiplier


# Called every physics tick. 'delta' is constant
func _physics_process(delta: float) -> void:
	input_axis = Input.get_vector(
		&"pm_movebackward", &"pm_moveforward", &"pm_moveleft", &"pm_moveright"
	)

	direction_input()

	if is_on_floor():
		if Input.is_action_just_pressed(&"jump"):
			velocity.y = jump_height
	else:
		velocity.y -= gravity * delta

	accelerate(delta)

	move_and_slide()


func direction_input() -> void:
	direction = Vector3()
	var aim: Basis = get_global_transform().basis
	direction = aim.z * -input_axis.x + aim.x * input_axis.y


func get_accel() -> float:
	var temp_vel := velocity
	temp_vel.y = 0

	var temp_accel: float
	if direction.dot(temp_vel) > 0:
		temp_accel = acceleration
	else:
		temp_accel = deceleration

	if not is_on_floor():
		temp_accel *= air_control

	return temp_accel


func accelerate(delta: float) -> void:
	# Using only the horizontal velocity, interpolate towards the input.
	var temp_vel := velocity
	temp_vel.y = 0

	var temp_accel := get_accel()
	var target: Vector3 = direction * speed

	temp_vel = temp_vel.lerp(target, temp_accel * delta)

	velocity.x = temp_vel.x
	velocity.z = temp_vel.z
