extends Area3D

const CONT_SPEED = 2
 # MADENİ PARANIN HER KAREDE KAÇ DERECE DÖNÜCEĞİNİ BELİRLİYO
@export var hud : CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	hud = get_node("/root/Level2/HUD1")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	rotate_y(deg_to_rad(CONT_SPEED))
	
	#if has_overlapping_bodies(): #sistemei yorduğu için sinyale geçilmiştir
		#queue_free()

	

func _on_body_entered(_body: Node3D) -> void:
	Global.coin2 += 1
	hud.get_node("CoinsLaber").text = str(Global.coins2)
	if Global.coins2 >= Global.NUM_COİNS_TO_WIN:
		get_tree().change_scene_to_file("res://manu_win.tscn")
	set_collision_layer_value(3,false)
	set_collision_mask_value(1,false)
	$AnimationPlayer.play("bounce")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
