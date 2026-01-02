extends AnimatableBody3D
# Hedeflenen para sayısı (İstersen burayı değiştirebilirsin)
var hedef_para_sayisi = 5

func _on_area_3d_body_entered(body: Node3D) -> void:

	# 1. Çarpan kişi Steve mi?
	if body.name == "Steve":
		
		# 2. Yeterince parası var mı?
		if Global.coins >= hedef_para_sayisi:
			print("KAZANDIN! Menüye gidiliyor...")
			# Kazanma ekranını aç
			get_tree().change_scene_to_file("res://manu_win.tscn")
			
		else:
			get_tree().change_scene_to_file("res://para_yetmeti.tscn")
