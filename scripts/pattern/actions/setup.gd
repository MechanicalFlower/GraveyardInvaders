extends ActionLeaf

@export var charge_type: Charge


func before_run(actor: Node, _blackboard: Blackboard) -> void:
	actor.linear_velocity = Vector3.ZERO

	# Compute the "world matrix" to apply to the pattern
	# This is useful to always focus the player and made some variation with the rotation
	var current_target: Vector3 = actor.player.global_position
	current_target.y = 0
	actor.pattern_transform = Transform3D(Basis(Vector3.UP, randf_range(0, TAU)), current_target)

	# Made the boss looking to the player
	var dest := charge_type.start_pos(actor.pattern_transform)
	actor.look_at(Vector3(dest.x, actor.global_position.y, dest.z), Vector3.UP, true)


func tick(actor: Node, _blackboard: Blackboard) -> int:
	if actor.global_position.distance_to(charge_type.start_pos(actor.pattern_transform)) < 2.5:
		if actor.life() < 10 and actor is Ghost:
			actor.enable_shadow_copies()
		return SUCCESS

	actor.apply_central_impulse(
		(
			(charge_type.start_pos(actor.pattern_transform) - actor.global_position).normalized()
			* actor.speed
			* get_physics_process_delta_time()
		)
	)

	return RUNNING
