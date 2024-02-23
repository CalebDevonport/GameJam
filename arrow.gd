extends RigidBody2D

# Called when the node enters the scene tree for the first time.
enum {UP, DOWN, LEFT, RIGHT}
func _ready():
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func start(pos, direction):
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
