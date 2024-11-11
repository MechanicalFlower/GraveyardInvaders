extends Node3D


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	# Handle debug arguments
	var args := OS.get_cmdline_user_args()
	if "--win" in args:
		Global.set_score(self)
	elif "--dead" in args:
		Global.player_is_dead = true
		Global.set_score(self)
	elif "--1hp" in args:
		Global.debug_1hp = true

	Global.start_time = Time.get_unix_time_from_system()

	CommandServer.register_command(
		(
			CommandBuilder
			. new()
			. Literal("ammo")
			. Literal("set")
			. Validated("quantity", _is_valid_int_positive, 0)
			. Tag_gn("int", func(s): return int(s))
			. Callback($Player/Head/Cannon.remaining_ammo_changed.emit, ["quantity"])
			. Build()
		)
	)

	CommandServer.register_command(
		(
			CommandBuilder
			. new()
			. Literal("ammo")
			. Literal("give")
			. Validated("quantity", _is_valid_int_positive, 0)
			. Tag_gn("int", func(s): return int(s))
			. Callback($PumpkinSpawner/PumpkinSpawnRange.reload_player.emit, ["quantity"])
			. Build()
		)
	)

	$UI/CommandTerminal/__guts__.get_node("%TERMINAL-PANEL").connect(
		"command_ran", $Restart._on_command_ran
	)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"quit"):
		get_tree().quit()

	if event.is_action_pressed(&"change_mouse_input"):
		match Input.get_mouse_mode():
			Input.MOUSE_MODE_CAPTURED:
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			Input.MOUSE_MODE_VISIBLE:
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed:
			match event.keycode:
				KEY_T:
					get_tree().paused = true
					$UI/CommandTerminal.show()
					$UI/CommandTerminal/__guts__.get_node("%TERMINAL-LINE-EDIT").grab_focus()
					get_tree().root.set_input_as_handled()


func _process(_delta):
	if Global.player_is_dead:
		Global.set_score(self)

	for altar in get_tree().get_nodes_in_group("altar"):
		if not altar.triggered:
			return
	if len(get_tree().get_nodes_in_group("boss")) == 0:
		Global.set_score(self)


func _is_valid_int_positive(s: String) -> bool:
	return s.to_int() > 0
