class_name Boss
extends RigidBody3D

@export var type: String
@export var initial_speed: int = 10

var speed := initial_speed
var cancel_action := false
var pattern_transform: Transform3D

@onready var weakpoint: Weakpoint = $Weakpoint
@onready var blink_component = $BlinkComponent
@onready var life_component = $LifeComponent
@onready var hit_sound_component = $HitSoundComponent
@onready var player: Node3D = get_tree().get_nodes_in_group(&"player")[0]


func _ready():
	add_to_group("boss")
	weakpoint.connect("hit", hit)


func hit(damage: int) -> void:
	if damage > 4:
		# cancel current action
		cancel_action = true
		$BeehaveTree.interrupt()

	# play hit vfx
	blink_component.blink()
	# play hit sfx
	hit_sound_component.play()
	# decrease life
	life_component.apply_damage(damage)
	# increase speed
	speed += damage


func life() -> int:
	return life_component.life
