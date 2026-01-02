extends AnimatableBody3D

# @export komutu, bu değişkeni sağdaki "Inspector" panelinde görünür yapar.
# Buradan hızı değiştirebilirsin. Eksi (-) değer verirsen ters yöne döner.
@export var donus_hizi: float = 0.5

func _physics_process(delta: float) -> void:
	# Y ekseni (yukarı bakan eksen) etrafında döndürme işlemi.
	# delta ile çarpmamızın sebebi, oyunun kasması veya hızlanması durumunda
	# dönüşün hep akıcı ve aynı hızda kalmasını sağlamaktır.
	rotate_y(donus_hizi * delta)
