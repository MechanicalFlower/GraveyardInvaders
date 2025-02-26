extends Node

@export_node_path var root_path: NodePath = ^"../"

var blink_material: ShaderMaterial = preload("res://resources/materials/blink.tres").duplicate(true)

var blink_activated: bool = false
var blink_timer: float = 0

@onready var blink_time: float = 2.0
@onready var root_node: Node = get_node(root_path)


func _ready():
	setup_blink_material(root_node)


func _process(delta):
	if blink_activated:
		if blink_timer <= 0:
			blink_material.set_shader_parameter("hit", false)
			blink_activated = false
		else:
			# decrease timer
			blink_timer -= delta


func setup_blink_material(root: Node):
	for child in root.get_children():
		if child is MeshInstance3D:
			child.set_material_overlay(blink_material)
		setup_blink_material(child)


func blink():
	blink_material.set_shader_parameter("hit", true)
	blink_activated = true
	# reset timer
	blink_timer = blink_time
