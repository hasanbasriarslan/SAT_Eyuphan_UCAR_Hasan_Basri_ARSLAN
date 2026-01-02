extends Control



func _on_button_pressed() -> void:
	
	SesManager.play_button_ses()
	get_tree().change_scene_to_file("res://bölümmenüsü.tscn")


func _on_button_2_pressed() -> void:
	SesManager.play_button_ses()
	get_tree().change_scene_to_file("res://control.tscn")
