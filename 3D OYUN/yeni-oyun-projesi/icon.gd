extends Sprite3D
var coins = 5
var player_name = "robot"
var hearts = 3.5
const SPEED =2
var x = coins / SPEED
var is_godot_awesone = true
var key_collected = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(add_these_numbers(5,6))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#minion()
	check_imputs()
func minion():
	print("BANANA")
func add_these_numbers(x,y):
	var sun = x + y
	return sun  
func check_imputs():
	if Input.is_action_pressed("ui_left"):
		rotate_y(deg_to_rad(-SPEED))
	elif Input.is_action_pressed("ui_right"):
		rotate_y(deg_to_rad(SPEED))
