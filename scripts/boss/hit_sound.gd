extends Node

const SOUNDS = [
	preload("res://assets/sounds/sfx/hit/hit1.ogg"),
	preload("res://assets/sounds/sfx/hit/hit2.ogg"),
	preload("res://assets/sounds/sfx/hit/hit3.ogg"),
	preload("res://assets/sounds/sfx/hit/hit4.ogg"),
	preload("res://assets/sounds/sfx/hit/hit5.ogg"),
]

@onready var player = get_node(^"%AudioStreamPlayer")


func _ready() -> void:
	randomize()


func play() -> void:
	var audio: AudioStreamOggVorbis = SOUNDS[randi() % len(SOUNDS)]

	player.stream = audio
	player.play()
