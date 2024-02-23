extends Node

var timer: Timer
var velocity = 200
var spawn_points = []
var box = null
var score
var boxVisible = false
var endGame = false

@export var arrow_scene: PackedScene
@export var goal_scene: PackedScene
@export var box_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	score = 0
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = 1
	timer.start()
	timer.timeout.connect(_on_timer_timeout)
	
	var width = get_viewport().get_visible_rect().size.x
	var height = get_viewport().get_visible_rect().size.y
	box = box_scene.instantiate()
	add_child(box)
	box.position.x = 350
	box.position.y = -770
	box.isBoxVisible.connect(_box_is_visible)
	
	
	var spawn_x_size = width / 5
	spawn_points = [spawn_x_size, spawn_x_size * 2, spawn_x_size * 3, spawn_x_size * 4]
	$LeftGoal.start(Vector2(spawn_points[0], 600), 0)
	$UpGoal.start(Vector2(spawn_points[1], 600), 1)
	$DownGoal.start(Vector2(spawn_points[2], 600), 2)
	$RightGoal.start(Vector2(spawn_points[3], 600), 3)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if box.position.y >= 350:
		endGame = true
	if !endGame: 
		box.position.y = box.position.y + ( 50 *delta)
		if box.position.y == 350:
			boxVisible = false
	if endGame:
		$Hud.update_score(str(score) + " seconds. GAME OVER")
	

func _on_timer_timeout():
	if timer.wait_time > 0.2:
		timer.wait_time -= 0.02
		velocity += 10
		
	#print(timer.wait_time)
	
	
	var arrow = arrow_scene.instantiate()

	# Choose a random location on Path2D.
	var arrow_spawn_index = randi_range(0, 3)
	arrow.position = Vector2(spawn_points[arrow_spawn_index], 0)
	arrow.linear_velocity = Vector2.DOWN * velocity

	add_child(arrow)
	arrow.start(arrow_spawn_index)


func _on_arrow_missed():
	if !endGame:
		print("score=" + str(score))
		box.position.y = box.position.y + 20

func _on_increase_point():
	
	print("score=" + str(score))
	if boxVisible && !endGame:
		box.position.y = box.position.y - 70 
		if box.position.y <= -400:
			boxVisible = false

func _box_is_visible():
	if boxVisible != true:
		boxVisible = true	
	
func increase_score():
	if !endGame: 
		score += 1
		$Hud.update_score(str(score) + " seconds")
