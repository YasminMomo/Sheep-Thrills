extends Control

func _on_tryagain_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
