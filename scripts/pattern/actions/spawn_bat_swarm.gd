extends ActionLeaf

const BatScene = preload("res://scenes/bat.tscn")

@export var max_concurrent_bats := 5


func before_run(actor: Node, _blackboard: Blackboard) -> void:
	actor.linear_velocity = Vector3.ZERO

	var current_target: Vector3 = actor.player.global_position
	current_target.y = 0

	# Made the boss looking to the player
	actor.look_at(
		Vector3(current_target.x, actor.global_position.y, current_target.z), Vector3.UP, true
	)


func tick(actor: Node, _blackboard: Blackboard) -> int:
	if actor.global_position.y < 3:
		return FAILURE

	# Spawn bats
	var bat_count = len(get_tree().get_nodes_in_group("bat"))

	if bat_count >= max_concurrent_bats:
		return SUCCESS

	var spawn_shape = actor.get_node("BatSpawnArea") as CollisionShape3D
	var spawn_size = spawn_shape.shape.size
	var spawn_center = spawn_shape.global_position
	var x = randi_range(spawn_center.x - spawn_size.x / 2, spawn_center.x + spawn_size.x / 2)
	var y = randi_range(spawn_center.y - spawn_size.y / 2, spawn_center.y + spawn_size.y / 2)
	var z = randi_range(spawn_center.z - spawn_size.z / 2, spawn_center.z + spawn_size.z / 2)
	var bat = BatScene.instantiate()
	actor.get_parent().add_child(bat)
	bat.global_position = Vector3(x, y, z)

	bat_count += 1
	return RUNNING
