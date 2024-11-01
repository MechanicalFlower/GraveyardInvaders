extends ActionLeaf

@export var charge_type: Charge


func before_run(actor: Node, _blackboard: Blackboard) -> void:
	actor.linear_velocity = Vector3.ZERO

	# Update the matrix to apply to the pattern
	var current_target: Vector3 = actor.player.global_position
	current_target.y = 0
	actor.pattern_transform.origin = current_target

	# Made the boss looking to the player
	var dest := charge_type.end_pos(actor.pattern_transform)
	actor.look_at(Vector3(dest.x, actor.global_position.y, dest.z), Vector3.UP, true)


func tick(actor: Node, _blackboard: Blackboard) -> int:
	actor.apply_central_impulse(
		(
			charge_type.attack_direction(actor.pattern_transform).normalized()
			* actor.speed
			* get_physics_process_delta_time()
		)
	)

	return RUNNING
