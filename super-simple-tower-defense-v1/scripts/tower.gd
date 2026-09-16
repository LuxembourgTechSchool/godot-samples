extends Node2D

@export var bullet_scene: PackedScene
@export var fire_rate := 1.0
@export var range := 300.0

var time_since_shot := 0.0


func _process(delta: float) -> void:
	time_since_shot += delta

	if time_since_shot >= fire_rate:
		shoot()
		time_since_shot = 0.0


func shoot() -> void:
	var target = find_nearest_monster()

	if target == null:
		return

	# Create a bullet and aim it at the target.
	var bullet = bullet_scene.instantiate()
	get_tree().current_scene.add_child(bullet)

	bullet.global_position = global_position
	bullet.target = target


func find_nearest_monster():
	var nearest_monster = null
	var nearest_distance = range

	# Look through every monster currently alive.
	for monster in get_tree().current_scene.get_node("Monsters").get_children():

		var distance = global_position.distance_to(monster.global_position)

		if distance < nearest_distance:
			nearest_distance = distance
			nearest_monster = monster

	return nearest_monster
