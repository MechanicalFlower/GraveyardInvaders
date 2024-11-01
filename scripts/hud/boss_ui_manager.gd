extends Control

const BossUI = preload("res://scenes/hud/boss_ui.tscn")

var boss_ui_instances = {}


func _process(_delta: float) -> void:
	for boss in get_tree().get_nodes_in_group("boss"):
		if boss not in boss_ui_instances:
			boss_ui_instances[boss] = BossUI.instantiate()
			boss_ui_instances[boss].boss = boss
			add_child(boss_ui_instances[boss])

	var keys_to_erase = []
	for boss in boss_ui_instances:
		if not is_instance_valid(boss):
			keys_to_erase.append(boss)
			boss_ui_instances[boss].queue_free()

	for key in keys_to_erase:
		boss_ui_instances.erase(key)
