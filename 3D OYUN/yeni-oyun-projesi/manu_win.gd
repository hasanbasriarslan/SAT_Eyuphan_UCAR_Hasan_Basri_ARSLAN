extends Control

func _on_button_pressed() -> void:
	SesManager.play_button_ses()
	get_tree().change_scene_to_file("res://menu_title.tscn")
func _ready():
	SesManager.play_level_ses()
	SesManager.play_menü_ses()
	# 1. MOUSE'U GÖRÜNÜR YAP
	# Oyun içinde gizlediğimiz mouse'u burada tekrar açıyoruz.
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	# 2. KLAVYE KONTROLÜ (Focus)
	# Sahne açılır açılmaz butonu seçili hale getirir.
	# Böylece Space veya Enter tuşuna basınca buton çalışır.
	$Button.grab_focus()
