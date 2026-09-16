extends CharacterBody2D

@export var max_health := 10
@export var speed := 100.0
@onready var health_bar = $ProgressBar

var health: int
var path: Path2D
var progress := 0.0


func _ready() -> void:
	health = max_health
	health_bar.max_value = max_health
	health_bar.value = health


func _process(delta: float) -> void:
	if path == null:
		return

	# Move forward along the path.
	progress += speed * delta

	var path_position := path.curve.sample_baked(progress)
	var next_position := path.curve.sample_baked(progress + 10)

	global_position = path.to_global(path_position)

	# Rotate the monster toward the next point.
	look_at(path.to_global(next_position))

	# Keep the health bar horizontal.
	health_bar.rotation = -rotation

	if progress >= path.curve.get_baked_length():
		reached_end()


func take_damage(amount: int) -> void:
	# Reduce health when hit.
	health -= amount

	# Update the health bar.
	health_bar.value = health

	if health <= 0:
		die()


func die() -> void:
	queue_free()


func reached_end() -> void:
	# Tell the level to restart when we reach the end.
	get_tree().current_scene.restart_level()
