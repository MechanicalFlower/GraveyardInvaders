extends Node

var start_time = Time.get_unix_time_from_system()
var player_is_dead: bool = false

# Debug
var debug_1hp: bool = false

var ammo_used: int = 0
var weakpoint_hit: int = 0
var played_time: float
var killed_boss: int = 0

var max_played_time := 30.0 * 60.0  # 30 minutes
var max_ammo_used := 200.0  # one ammo for each life point
var max_weakpoint_hit := 10.0  # max_ammo_used / 4
var max_killed_boss := 3.0


func get_score():
	var score
	if player_is_dead:
		score = (
			clampf(weakpoint_hit / max_weakpoint_hit, 0.0, 1.0) * 0.15
			+ clampf(killed_boss / max_killed_boss, 0.0, 1.0) * 0.5
		)
	else:
		score = (
			clampf((max_played_time - played_time) / max_played_time, 0.0, 1.0) * 0.2
			+ clampf((max_ammo_used - ammo_used) / max_ammo_used, 0.0, 1.0) * 0.15
			+ clampf(weakpoint_hit / max_weakpoint_hit, 0.0, 1.0) * 0.15
			+ clampf(killed_boss / max_killed_boss, 0.0, 1.0) * 0.5
		)

	if score >= 0.9:
		return "S"
	if score >= 0.7:
		return "A"
	if score >= 0.4:
		return "B"
	if score >= 0.2:
		return "C"
	return "D"


func set_score(main):
	main.get_node("Theme").stop()

	var end_time = Time.get_unix_time_from_system()
	played_time = end_time - start_time

	main.get_node("Player/PlayerUI").hide()
	main.get_node("UI/BossUIManager").hide()
	main.get_node("Player/Head/Cannon/CenterContainer").hide()

	main.get_node("UI/EndMenu/CenterContainer/VBoxContainer/TimeRow/Value").set_text(
		"%02d:%02d" % [played_time / 60, fmod(played_time, 60)]
	)
	main.get_node("UI/EndMenu/CenterContainer/VBoxContainer/AmmoRow/Value").set_text(str(ammo_used))
	main.get_node("UI/EndMenu/CenterContainer/VBoxContainer/WeakpointRow/Value").set_text(
		str(weakpoint_hit)
	)
	main.get_node("UI/EndMenu/CenterContainer/VBoxContainer/Score/Value").set_text(get_score())

	if player_is_dead:
		# Game Over
		main.get_node("UI/EndMenu/Advices").show()
		main.get_node("UI/EndMenu/ColorRect").set_color(Color("#00000071"))
		main.get_node("UI/EndMenu/CenterContainer/VBoxContainer/Label").set_text(
			"You lose, try again.."
		)
	else:
		main.get_node("UI/EndMenu/ColorRect").set_color(Color("#ffffff86"))
		main.get_node("UI/EndMenu/CenterContainer/VBoxContainer/Label").set_text(
			"You defeat all bosses !"
		)

	main.get_node("UI/EndMenu").show()
	get_tree().paused = true
