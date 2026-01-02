extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SesManager.play_level_ses()
	Global.coins = 0
	Global.enemy = 0
	Global.current_level_path = scene_file_path
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
