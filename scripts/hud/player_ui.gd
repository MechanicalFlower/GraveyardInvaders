extends Node


func _on_life_component_life_changed(new_life: Variant) -> void:
	%PlayerHealthLabel.text = "%s" % new_life


func _on_canon_remaining_ammo_changed(new_quantiy: Variant) -> void:
	%AmmoLabel.text = "%s" % new_quantiy
