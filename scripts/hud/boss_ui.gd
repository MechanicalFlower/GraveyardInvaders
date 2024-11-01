extends Control

@export var boss: Boss

@onready var name_label: Label = get_node("%BossNameLabel")
@onready var health_bar: TextureProgressBar = get_node("%BossHealthBar")
@onready var boss_life_component: LifeComponent = boss.get_node("LifeComponent")


func _ready() -> void:
	name_label.text = boss.type
	health_bar.max_value = boss_life_component.initial_life
	health_bar.value = boss_life_component.life
	boss_life_component.connect("life_changed", func(new_life): health_bar.value = new_life)
