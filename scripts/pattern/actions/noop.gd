extends ActionLeaf

# The wait time in seconds
@export var wait_time := 0.0

@onready var cache_key = "cooldown_%s" % self.get_instance_id()


func tick(actor: Node, blackboard: Blackboard) -> int:
	if actor is Ghost:
		actor.disable_shadow_copies()

	var remaining_time = blackboard.get_value(cache_key, 0.0, str(actor.get_instance_id()))

	if remaining_time > 0.0:
		remaining_time -= get_physics_process_delta_time()
		blackboard.set_value(cache_key, remaining_time, str(actor.get_instance_id()))
		return RUNNING

	if actor.cancel_action:
		actor.cancel_action = false

		actor.linear_velocity = Vector3.ZERO
		actor.apply_central_impulse(
			(actor.global_position - actor.player.global_position).normalized() * 20
		)

		var current_target: Vector3 = actor.player.global_position
		current_target.y = 0
		actor.look_at(current_target, Vector3.UP, true)

		blackboard.set_value(cache_key, wait_time, str(actor.get_instance_id()))
		return RUNNING

	actor.linear_velocity = Vector3.ZERO
	return SUCCESS
