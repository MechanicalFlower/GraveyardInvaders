extends CSGCylinder3D

signal remaining_ammo_changed(new_quantiy)

const AmmoScene := preload("res://scenes/weapon/ammo.tscn")

@export var max_ammo_count := 10
var ammo_count := 0

@onready var spawn: Marker3D = $Marker3D
@onready var player: AudioStreamPlayer = get_node(^"AudioStreamPlayer")


func _ready():
	ammo_count = max_ammo_count
	remaining_ammo_changed.emit(ammo_count)

	for spawner in get_tree().get_nodes_in_group("spawner"):
		spawner.connect("reload_player", reload)


func _unhandled_input(event):
	if event.is_action_pressed(&"shoot") and ammo_count > 0 and $CanonTimer.time_left == 0:
		Global.ammo_used += 1
		# TODO: play shoot sfx
		player.play()

		var ammo := AmmoScene.instantiate()
		get_owner().get_parent().add_child(ammo)
		ammo.global_position = spawn.global_position

		var dir = (Vector3.FORWARD * 50) - spawn.position
		var speed := 50
		ammo.apply_impulse(get_parent().global_basis * dir.normalized() * speed - spawn.position)

		ammo_count -= 1
		remaining_ammo_changed.emit(ammo_count)
		$CanonTimer.start()


func reload(ammo_qty: int):
	ammo_count += ammo_qty
	remaining_ammo_changed.emit(ammo_count)
