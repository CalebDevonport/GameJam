extends Area2D

var screen_size
signal arrow_missed
enum {UP, DOWN, LEFT, RIGHT}
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func start(pos, direction):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	if direction == UP:
		$AnimatedSprite2D.animation = "up"
	elif direction == DOWN:
		$AnimatedSprite2D.animation = "down"
	elif direction == LEFT:
		$AnimatedSprite2D.animation = "left"
	elif direction == RIGHT:
		$AnimatedSprite2D.animation = "right"


func _on_body_exited(body):
	arrow_missed.emit()
