extends AnimatableBody3D

@export var move_offset := Vector3(0, 5, 0) 
@export var duration := 2.0 
@export var auto_return := false

var has_triggered = false 

func _ready():
	print("Platform hazır.") # Oyun başlayınca bu yazıyı görmelisin

func start_movement():
	if has_triggered: return 
	has_triggered = true
	
	print("HAREKET BAŞLADI!") # Platform hareket edince bu yazar
	
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "position", position + move_offset, duration)
	
	if auto_return:
		tween.tween_interval(1.0)
		tween.tween_property(self, "position", position, duration)
		tween.finished.connect(func(): has_triggered = false)

# --- EN ÖNEMLİ KISIM: Sinyal Fonksiyonu ---
func _on_area_3d_body_entered(body: Node3D) -> void:
	print("Platforma çarpan şey: ", body.name) # Çarpan her şeyi yazar
	
	if body.name == "Steve":
		print("Steve algılandı, asansör çalışıyor...")
		start_movement()
