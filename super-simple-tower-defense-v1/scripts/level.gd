extends Node2D

@export var monster_scene: PackedScene
@export var tower_scene: PackedScene

@onready var monster_path = $MonsterPath
@onready var monsters = $Monsters
@onready var towers = $Towers


func _ready() -> void:
	# Start spawning monsters.
	$MonsterSpawnTimer.timeout.connect(spawn_monster)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse_click"):
		place_tower(get_global_mouse_position())


func spawn_monster() -> void:
	# Create a new monster and give it our path.
	var monster = monster_scene.instantiate()
	monsters.add_child(monster)

	monster.path = monster_path


func place_tower(position: Vector2) -> void:
	# Create a tower where the player clicked.
	var tower = tower_scene.instantiate()
	towers.add_child(tower)

	tower.global_position = position


func restart_level() -> void:
	# Reload the current level.
	get_tree().reload_current_scene()
