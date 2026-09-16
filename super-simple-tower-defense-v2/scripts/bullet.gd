extends Area2D

@export var speed := 500.0
@export var damage := 2

var target: Node2D



func _process(delta: float) -> void:
	if target == null or not is_instance_valid(target):
		queue_free()
		return

	# Move toward the target.
	var direction := global_position.direction_to(target.global_position)

	global_position += direction * speed * delta

	# Rotate the bullet in the direction it is travelling.
	rotation = direction.angle()

	if global_position.distance_to(target.global_position) < 10:
		target.take_damage(damage)
		queue_free()
