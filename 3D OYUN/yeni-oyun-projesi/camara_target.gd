extends Node3D

# Class name satırını sildim, çakışma hatası vermesin diye.

# --- AYARLAR (INSPECTOR) ---

@export_group("Mouse Ayarları")
@export var mouse_sensitivity : float = 0.003
@export var min_pitch : float = -89.0 
@export var max_pitch : float = 89.0 
@export var smooth_mouse : bool = true
@export var mouse_lerp_speed : float = 20.0

@export_group("FOV & Zoom")
@export var base_fov : float = 75.0
@export var run_fov : float = 90.0
@export var zoom_fov : float = 40.0
@export var fov_change_speed : float = 8.0

@export_group("Hareket Efektleri (Tilt & Lean)")
@export var enable_tilt : bool = true
@export var tilt_amount : float = 0.05
@export var tilt_speed : float = 5.0

@export_group("Headbob (Sallanma)")
@export var enable_headbob : bool = true
@export var bob_frequency : float = 2.0
@export var bob_amplitude : float = 0.08
@export var bob_smoothness : float = 10.0

# --- DEĞİŞKENLER ---
var _mouse_rotation : Vector3 = Vector3.ZERO
var _current_tilt : float = 0.0
var _bob_timer : float = 0.0
var _target_fov : float = 75.0

# --- REFERANSLAR (BURASI DÜZELTİLDİ) ---
# Senin hiyerarşine göre kameranın doğru yolu:
@onready var camera : Camera3D = $camara_Target/Camera3D
# Parent node (Steve)
@onready var player : CharacterBody3D = $".."

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if camera:
		_target_fov = base_fov
	else:
		print("HATA: Kamera bulunamadı! Lütfen scriptteki yolu kontrol et.")

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		_mouse_rotation.x -= event.relative.y * mouse_sensitivity
		_mouse_rotation.y -= event.relative.x * mouse_sensitivity
		
		_mouse_rotation.x = clamp(_mouse_rotation.x, deg_to_rad(min_pitch), deg_to_rad(max_pitch))

		if not smooth_mouse:
			# DÜZELTİLEN KISIM: transform.rotation yerine rotation
			rotation.x = _mouse_rotation.x
			if player:
				player.rotation.y = _mouse_rotation.y

func _process(delta: float) -> void:
	# Eğer player veya camera yoksa kodu çalıştırma (Çökmemesi için)
	if !player or !camera: return
	
	_handle_mouse_smooth(delta)
	_handle_fov_zoom(delta)
	_handle_tilt(delta)
	_handle_headbob(delta)

func _handle_mouse_smooth(delta: float) -> void:
	if smooth_mouse:
		rotation.x = lerp_angle(rotation.x, _mouse_rotation.x, mouse_lerp_speed * delta)
		player.rotation.y = lerp_angle(player.rotation.y, _mouse_rotation.y, mouse_lerp_speed * delta)

func _handle_fov_zoom(delta: float) -> void:
	# Input Map'te "zoom" tuşu tanımlı değilse hata vermesin diye kontrol ekledik
	var is_zooming = false
	if InputMap.has_action("zoom"):
		is_zooming = Input.is_action_pressed("zoom")
	
	var speed = player.velocity.length()
	var is_running = speed > 6.0
	
	if is_zooming:
		_target_fov = zoom_fov
	elif is_running and player.is_on_floor():
		_target_fov = run_fov
	else:
		_target_fov = base_fov
	
	camera.fov = lerp(camera.fov, _target_fov, fov_change_speed * delta)

func _handle_tilt(delta: float) -> void:
	if !enable_tilt: return
	
	# 'ui_left' vb. yerine kendi tuşlarını buraya yazabilirsin
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	var target_tilt = -input_dir.x * tilt_amount
	rotation.z = lerp(rotation.z, target_tilt, tilt_speed * delta)

func _handle_headbob(delta: float) -> void:
	if !enable_headbob: return
	
	var velocity_clamped = player.velocity.length()
	var is_moving_on_floor = player.is_on_floor() and velocity_clamped > 0.1
	
	if is_moving_on_floor:
		_bob_timer += delta * velocity_clamped * bob_frequency
		var bob_offset_y = sin(_bob_timer) * bob_amplitude
		var bob_offset_x = cos(_bob_timer * 0.5) * (bob_amplitude * 0.5)
		
		camera.position.y = lerp(camera.position.y, bob_offset_y, bob_smoothness * delta)
		camera.position.x = lerp(camera.position.x, bob_offset_x, bob_smoothness * delta)
	else:
		_bob_timer = 0.0
		camera.position.y = lerp(camera.position.y, 0.0, bob_smoothness * delta)
		camera.position.x = lerp(camera.position.x, 0.0, bob_smoothness * delta)
