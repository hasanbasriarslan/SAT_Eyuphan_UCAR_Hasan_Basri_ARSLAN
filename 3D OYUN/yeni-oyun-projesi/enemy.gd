extends CharacterBody3D


const speed = 2.0

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@export var direction := Vector3(-1,0,0)
@export var turns_around_at_edges := true
@export var hud : CanvasLayer
var turnıng := false
func _physics_process(delta: float) -> void:
	
	velocity.x = speed * direction.x
	velocity.z = speed * direction.z
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta


	move_and_slide()

	if is_on_wall() and not turnıng:
		turn_arround()
	if not $RayCast3D.is_colliding() and is_on_floor() and not turnıng and turns_around_at_edges:
		turn_arround()
func turn_arround():
	turnıng = true
	var dir = direction
	direction = Vector3.ZERO
	global_position -= dir * 0.1

	var turn_tween = create_tween()
	turn_tween.tween_property(self, "rotation_degrees", Vector3(0,180,0),0.6 ).as_relative()
	await get_tree().create_timer(0,6).timeout
	direction.x = dir.x * -1
	direction.z = dir.z * -1
	turnıng = false


func _on_sides_checker_body_entered(body: Node3D) -> void:
	SesManager.play_enemy_ses()
	get_tree().change_scene_to_file("res://menu_game_over.tscn")



func _on_top_checker_body_entered(body: Node3D) -> void:
	$AnimationPlayer.play("squash")
	$SesÖlüm.play()
	Global.enemy += 1
 

	if Global.enemy >= Global.NUM_ENEMY_TO_WIN:
		get_tree().change_scene_to_file("res://manu_win.tscn")
	body.bounce()
	$SidesChecker.set_collision_mask_value(1, false)
	$TopChecker.set_collision_mask_value(1, false)
	direction = Vector3.ZERO
	await get_tree().create_timer(1.5).timeout
	queue_free()
