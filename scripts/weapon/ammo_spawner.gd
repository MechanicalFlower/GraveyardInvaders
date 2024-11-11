extends Node3D

signal reload_player(quantity)

const ReloadScene = preload("res://scenes/weapon/reload.tscn")

@export var max_concurrent_reloads = 5

var reload_count = 0


func _on_timer_spawn_pumpkin_timeout() -> void:
	if reload_count < max_concurrent_reloads:
		var spawn_size = $CollisionShape3D.shape.size
		var spawn_center = position
		var x = randi_range(spawn_center.x - spawn_size.x / 2, spawn_center.x + spawn_size.x / 2)
		var z = randi_range(spawn_center.z - spawn_size.z / 2, spawn_center.z + spawn_size.z / 2)
		var pumpkin = ReloadScene.instantiate()
		add_child(pumpkin)
		pumpkin.global_position = global_position + Vector3(x, -0.5, z)

		reload_count += 1
		pumpkin.reload_taken.connect(_on_reload_taken)


func _on_reload_taken() -> void:
	reload_count -= 1
	reload_player.emit(5)
