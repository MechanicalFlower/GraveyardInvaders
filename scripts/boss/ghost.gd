class_name Ghost
extends Boss

var enabled := false
@onready var tween = create_tween()


func enable_shadow_copies():
	if not enabled:
		enabled = true
		$ShadowCopyLeft.show()
		$ShadowCopyRight.show()
		$ShadowCopyLeft/StaticBody3D.collision_layer = 2
		$ShadowCopyRight/StaticBody3D.collision_layer = 2

		tween.stop()
		tween = create_tween()
		tween.tween_property($ShadowCopyLeft, "position", Vector3(-9, -1.743, 0), 0.5).set_trans(
			Tween.TRANS_ELASTIC
		)
		(
			tween
			. parallel()
			. tween_property($ShadowCopyRight, "position", Vector3(9, -1.743, 0), 0.5)
			. set_trans(Tween.TRANS_ELASTIC)
		)


func disable_shadow_copies():
	if enabled:
		enabled = false
		$ShadowCopyLeft/StaticBody3D.collision_layer = 0
		$ShadowCopyRight/StaticBody3D.collision_layer = 0

		tween.stop()
		tween = create_tween()
		tween.tween_property($ShadowCopyLeft, "position", Vector3(0, -1.743, 0), 0.5).set_trans(
			Tween.TRANS_ELASTIC
		)
		(
			tween
			. parallel()
			. tween_property($ShadowCopyRight, "position", Vector3(0, -1.743, 0), 0.5)
			. set_trans(Tween.TRANS_ELASTIC)
		)
		tween.finished.connect($ShadowCopyLeft.hide)
		tween.finished.connect($ShadowCopyRight.hide)
