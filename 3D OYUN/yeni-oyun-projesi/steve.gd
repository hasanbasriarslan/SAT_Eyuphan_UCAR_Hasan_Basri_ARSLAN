extends CharacterBody3D



# --- AYARLAR ---
@export_group("Hareket Ayarları")
@export var walk_speed: float = 9
@export var run_speed: float = 9.0
@export var acceleration: float = 10.0
@export var deceleration: float = 25.0

@export_group("Zıplama Ayarları")
@export var jump_height: float = 3
@export var jump_time_to_peak: float = 0.4
@export var jump_time_to_fall: float = 0.35

@onready var jump_velocity: float = (2.0 * jump_height) / jump_time_to_peak
@onready var jump_gravity: float = (-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)
@onready var fall_gravity: float = (-2.0 * jump_height) / (jump_time_to_fall * jump_time_to_fall)

# --- REFERANSLAR ---
@onready var cam_kontrol = $camara_kontrol 
@onready var model = $Armature # Eğer modelinin adı farklıysa burayı düzelt
@onready var animation_player = $AnimationPlayer

var _current_speed : float = 0.0

func _physics_process(delta: float) -> void:
	# 1. YERÇEKİMİ
	if not is_on_floor():
		if velocity.y >= 0:
			velocity.y += jump_gravity * delta
		else:
			velocity.y += fall_gravity * delta

	# 2. ZIPLAMA
	if Input.is_action_just_pressed("jump") and is_on_floor():
		$SesJump.play()
		velocity.y = jump_velocity
		if animation_player: animation_player.play("jump")
		else:
			animation_player.play("jump")
	# 3. HAREKET YÖNÜ (DÜZELTİLEN KISIM BURASI)
	# WASD tuşlarını al
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	
	# Kameranın DÜNYA üzerindeki yönünü al (global_transform)
	var direction = (cam_kontrol.global_transform.basis * Vector3(input_dir.x, 0, input_dir.y))
	
	# Yönü normalize et (Çapraz giderken hızlanmasın)
	direction.y = 0 # Havaya doğru uçmasını engelle
	direction = direction.normalized()
	
	# 4. KOŞMA
	var target_speed = walk_speed
	if Input.is_action_pressed("run"):
		target_speed = run_speed
	
	# 5. HAREKET UYGULAMA
	if direction:
		_current_speed = move_toward(_current_speed, target_speed, acceleration * delta)
		
		velocity.x = direction.x * _current_speed
		velocity.z = direction.z * _current_speed
		
		# Karakterin yüzünü gittiği yöne çevir (Yumuşakça)
		var target_rotation = atan2(-direction.x, -direction.z)
		if model:
			model.global_rotation.y = lerp_angle(model.global_rotation.y, target_rotation, 10 * delta)
		
		if is_on_floor() and animation_player:
			if Input.is_action_pressed("run"):
				animation_player.play("run")
			else:
				animation_player.play("run") # Yürüme animasyonun varsa buraya 'walk' yaz
	else:
		_current_speed = move_toward(_current_speed, 0.0, deceleration * delta)
		velocity.x = move_toward(velocity.x, 0, deceleration * delta)
		velocity.z = move_toward(velocity.z, 0, deceleration * delta)
		
		if is_on_floor() and animation_player:
			animation_player.play("idle")

	move_and_slide()

func _on_fallzone_body_entered(body: Node3D) -> void:
	SesManager.play_fall_ses()
	if body == self:
		call_deferred("sahneyi_yenile")

func sahneyi_yenile():
	get_tree().change_scene_to_file("res://menu_game_over.tscn")


func bounce():
	velocity.y = jump_velocity * 0.7
