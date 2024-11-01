class_name Charge
extends Resource

@export var start: Vector3
@export var end: Vector3


func attack_direction(world: Transform3D) -> Vector3:
	return end_pos(world) - start_pos(world)


func start_pos(world: Transform3D) -> Vector3:
	return world * start


func end_pos(world: Transform3D) -> Vector3:
	return world * end

#var top_charge_attack = Charge.new(Vector3(0, 10, -20), Vector3(0, 0, 0))
#var front_charge_attack = Charge.new(Vector3(0, 0, -20), Vector3(0, 0, 20))
