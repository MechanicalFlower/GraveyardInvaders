extends Node


func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed:
			match event.keycode:
				KEY_R:
					get_tree().paused = false
					get_tree().reload_current_scene()
				KEY_ESCAPE:
					get_tree().quit()
