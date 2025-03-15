extends Control

func _on_playagain_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()
