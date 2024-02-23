extends Area2D

signal increase_point
signal arrow_missed
var screen_size
var direction_used
var has_collision = false
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed(_get_action_name(direction_used)) and has_collision:
		increase_point.emit()


func start(pos, direction):
	position = pos
	direction_used = direction
	show()
	$CollisionShape2D.disabled = false
	if direction == 0:
		$AnimatedSprite2D.animation = "left"
	elif direction == 1:
		$AnimatedSprite2D.animation = "up"
	elif direction == 2:
		$AnimatedSprite2D.animation = "down"
	elif direction == 3:
		$AnimatedSprite2D.animation = "right"

func _get_action_name(direction):
	if direction == 0:
		return "input_left"
	elif direction == 1:
		return "input_up"
	elif direction == 2:
		return "input_down"
	elif direction == 3:
		return "input_right"

func _on_area_exited(area):
	has_collision = false
	arrow_missed.emit()


func _on_area_entered(area):
	has_collision = true
