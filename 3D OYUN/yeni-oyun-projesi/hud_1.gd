extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CoinsLaber.text = str(0)

	$Label3.text = str(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#$CoinsLaber.text = str(Global.coins)
	$Label3.text = str(Global.enemy)
	$CoinsLaber.text = str(Global.coins)
