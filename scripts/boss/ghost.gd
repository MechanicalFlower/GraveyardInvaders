class_name Ghost
extends Boss


func enable_shadow_copies():
	$ShadowCopyLeft.show()
	$ShadowCopyLeft/StaticBody3D.collision_layer = 5
	$ShadowCopyRight.show()
	$ShadowCopyRight/StaticBody3D.collision_layer = 5


func disable_shadow_copies():
	$ShadowCopyLeft.hide()
	$ShadowCopyLeft/StaticBody3D.collision_layer = 0
	$ShadowCopyRight.hide()
	$ShadowCopyRight/StaticBody3D.collision_layer = 0
