extends CharacterBody2D

@export var max_health := 10
@export var speed := 100.0

var health: int
var path: Path2D
var progress := 0.0

#optional shape drawing, carefull to not over do it
func _draw():
	var red = Color("e5497bff")

	draw_rect(
		Rect2(-40, -40, 80, 80),
		red
	)
	
	
func _ready() -> void:
	health = max_health


func _process(delta: float) -> void:
	if path == null:
		return

	# Move forward along the path.
	progress += speed * delta

	var path_position = path.curve.sample_baked(progress)

	global_position = path.to_global(path_position)

	# Check if we reached the end of the path.
	if progress >= path.curve.get_baked_length():
		reached_end()


func take_damage(amount: int) -> void:
	# Reduce health when hit by a bullet.
	health -= amount

	if health <= 0:
		die()


func die() -> void:
	queue_free()


func reached_end() -> void:
	# Tell the level to restart when we reach the end.
	get_tree().current_scene.restart_level()
