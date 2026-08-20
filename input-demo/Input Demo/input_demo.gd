extends Node2D

func _process(delta: float) -> void:
	## checks if key is being held down
	if Input.is_action_pressed("move_right"):
		print("move right")
		
	##checks if key has just been pressed
	if Input.is_action_just_pressed("move_up"):
		print("move up")
		
	##checks if mouse has been clicked and also prints the position
	if Input.is_action_just_pressed("click"):
		print("mouse clicked")
		print(get_global_mouse_position())

## Input without the Input map and as an Event outside of _process
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		print("Right click!")
