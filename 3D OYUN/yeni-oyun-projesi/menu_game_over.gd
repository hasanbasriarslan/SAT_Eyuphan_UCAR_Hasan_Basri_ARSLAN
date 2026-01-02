extends Control

func _on_button_pressed() -> void:
	SesManager.stop_level_ses()
	SesManager.play_button_ses()
	get_tree().change_scene_to_file("res://menu_title.tscn")


func _ready():

	# 1. MOUSE'U GÖRÜNÜR YAP
	# Oyun içinde gizlediğimiz mouse'u burada tekrar açıyoruz.
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	# 2. KLAVYE KONTROLÜ (Focus)
	# Sahne açılır açılmaz butonu seçili hale getirir.
	# Böylece Space veya Enter tuşuna basınca buton çalışır.
	

func _on_button_2_pressed() -> void:
	SesManager.stop_menü_ses()
	SesManager.play_button_ses()
	# Global'de kayıtlı olan son bölüm neyse onu açar
	get_tree().change_scene_to_file(Global.current_level_path)
	
