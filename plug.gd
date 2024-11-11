extends "res://addons/gd-plug/plug.gd"


func _plugging():
	plug(
		"godot-extended-libraries/godot-debug-menu",
		{"commit": "0e5f15217285c76170039c9cefcf79c8ab0ec6b3", "renovate-branch": "master"}
	)
	plug(
		"rsubtil/controller_icons",
		{"commit": "9088a0f804ce2858f19aac044988c71fcaa015e2", "renovate-branch": "master"}
	)
	plug(
		"ItsKorin/Godot-Post-Process-Plugin",
		{"commit": "4e3f96f674d575478b0c24415fc9de0d7e617304", "renovate-branch": "main"}
	)
	plug(
		"Jummit/godot-destruction-plugin",
		{"commit": "eb7ccb7148245f14211b3d4ccd9ec32bfbc49ca2", "renovate-branch": "master"}
	)
	plug(
		"HungryProton/scatter",
		{"commit": "59147fc5b16f505ea54bf2c9ad65ae6b613a2c58", "renovate-branch": "v4"}
	)
	plug(
		"bitbrain/beehave",
		{
			"commit": "a8cb9fb4d17325137ab081c5e128d4cd919143d7",
			"renovate-branch": "godot-4.x",
			"exclude": ["addons/gdUnit4"]
		}
	)
	plug(
		"florianvazelle/EasyMenus",
		{"commit": "018ab39001f862abbd6ca424258a9a548589d61c", "renovate-branch": "master"}
	)
	plug(
		"20milliliter/command-terminal",
		{
			"commit": "4c15f8a9a3e4b9e8f8ae21bf408cc551435ab632",
			"renovate-branch": "main",
			"install_root": "addons/command-terminal",
			"include": ["."]
		}
	)
