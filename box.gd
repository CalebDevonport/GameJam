extends Node
signal isBoxVisible

# Called when the node enters the scene tree for the first time.
func _ready():
	return

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_visible_on_screen_notifier_2d_screen_entered():
	isBoxVisible.emit()
	
