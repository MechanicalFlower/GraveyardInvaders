extends Node


func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed:
			match event.keycode:
				KEY_F1:
					get_tree().paused = false
					get_tree().reload_current_scene()
				KEY_ESCAPE:
					get_tree().quit()


func _on_command_ran(_c):
	get_node("../UI/CommandTerminal").hide()
	get_tree().paused = false
