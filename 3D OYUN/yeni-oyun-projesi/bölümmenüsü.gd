extends Control




func _on_button_2_pressed() -> void:
	SesManager.stop_menü_ses()
	SesManager.play_button_ses()
	get_tree().change_scene_to_file("res://level_3.tscn")


func _on_button_3_pressed() -> void:
	SesManager.play_button_ses()
	get_tree().change_scene_to_file("res://menu_title.tscn")


func _on_button_4_pressed() -> void:
	SesManager.stop_menü_ses()
	SesManager.play_button_ses()
	get_tree().change_scene_to_file("res://level_1.tscn")


func _on_button_5_pressed() -> void:
	SesManager.stop_menü_ses()
	SesManager.play_button_ses()
	get_tree().change_scene_to_file("res://level_1_1.tscn")
