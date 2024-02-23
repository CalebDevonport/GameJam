extends Node

var timer: Timer
var velocity = 200
var spawn_points = []

@export var arrow_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = 1
	timer.start()
	timer.timeout.connect(_on_timer_timeout)
	
	var width = get_viewport().get_visible_rect().size.x
	var spawn_x_size = width / 5
	spawn_points = [spawn_x_size, spawn_x_size * 2, spawn_x_size * 3, spawn_x_size * 4]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	timer.wait_time -= 0.001
	velocity += 1
	
	var arrow = arrow_scene.instantiate()

	# Choose a random location on Path2D.
	var arrow_spawn_index = randi_range(0, 3)
	arrow.position = Vector2(spawn_points[arrow_spawn_index], 0)
	arrow.linear_velocity = Vector2.DOWN * velocity

	add_child(arrow)
	arrow.start(arrow_spawn_index)
