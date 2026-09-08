extends Node

@export var pipe_scene : PackedScene
@export var scroll_speed : int = 4
@export var pipe_delay : int = 100
@export var pipe_range : int = 200

var game_running : bool
var game_over : bool
var scroll
var score
var screen_size : Vector2i
var ground_height : int
var pipes: Array



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_window().size
	ground_height = $Ground.get_node("Sprite2D").texture.get_height()
	new_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if game_running:
		scroll += scroll_speed
		if scroll >= screen_size.x:
			scroll = 0
		$Ground.position.x = -scroll
		
		for pipe in pipes:
			pipe.position.x -= scroll_speed
	
func _input(event: InputEvent) -> void:
	if not game_over:
		if is_action_one(event):
			if game_running == false:
				start_game()
			else:
				if $Bird.flying:
					$Bird.flap()
					check_top()

func new_game() -> void:
	game_running = false
	game_over = false
	score = 0
	scroll = 0
	pipes.clear()
	get_tree().call_group("pipes", "queue_free")
	generate_pipes()
	$Bird.reset()
	$ScoreLabel.text = str(score)
	$GameOver.hide()

func start_game():
	game_running = true
	$Bird.flying = true
	$Bird.flap()
	$PipeTimer.start()
	
func is_action_one(event) -> bool:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			return true
	if event is InputEventKey:
		if event.keycode == KEY_SPACE and event.pressed:
			return true
			
	return false


func _on_pipe_timer_timeout() -> void:
	generate_pipes()
	
func generate_pipes() -> void:
	var pipe = pipe_scene.instantiate()
	pipe.position.x = screen_size.x + pipe_delay
	pipe.position.y = (screen_size.y - ground_height) / 2 + randi_range(-pipe_range, pipe_range)
	pipe.hit.connect(bird_hit)
	pipe.scored.connect(scored)
	add_child(pipe)
	pipes.append(pipe)
	
func check_top():
	if $Bird.position.y < 0:
		$Bird.falling = true
		stop_game()

func stop_game():
	$PipeTimer.stop()
	$GameOver.show()
	$Bird.flying = false
	game_running = false
	game_over = true

func bird_hit():
	$Bird.falling = true
	stop_game()

func scored():
	score += 1
	$ScoreLabel.text = str(score)

func _on_ground_hit() -> void:
	$Bird.falling = false
	stop_game()

func _on_game_over_restart() -> void:
	new_game()
