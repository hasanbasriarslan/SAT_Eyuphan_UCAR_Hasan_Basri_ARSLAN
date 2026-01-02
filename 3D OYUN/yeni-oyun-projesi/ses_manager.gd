extends Node


func _ready() -> void:
	play_menü_ses()

# Called when the node enters the scene tree for the first time.
func play_enemy_ses():
	$SesEnemy.play()
func play_coin_ses():
	$SesCoin.play()
func play_button_ses():
	$SesButton.play()
func play_fall_ses():
	$SesFall.play()
func play_menü_ses():
	$SesMenü.play()
func stop_menü_ses():
	$SesMenü.stop()
func play_level_ses():
	$SesLevel.play()
func stop_level_ses():
	$SesLevel.stop()
