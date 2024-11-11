class_name Bat
extends RigidBody3D

@onready var player: Node3D = get_tree().get_first_node_in_group(&"player")


func _ready():
	add_to_group("bat")

	# TODO: play sfx
	$"../Smoke".restart()

	look_at(player.global_position, Vector3.UP, true)


func _process(_delta: float) -> void:
	if linear_velocity == Vector3(0, 0, 0):
		apply_central_impulse((player.global_position - global_position).normalized() * 15.0)


func hit():
	# TODO: play sfx
	$"../Smoke".restart()
	queue_free()


func _on_body_entered(_body: Node) -> void:
	hit()
