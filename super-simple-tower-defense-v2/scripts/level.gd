extends Node2D

@export var monster_scene: PackedScene
@export var tower_scene: PackedScene

@onready var monster_path = $MonsterPath
@onready var monsters = $Monsters
@onready var towers = $Towers

var occupied_tiles: Array[Vector2i] = []

func _ready() -> void:
	# Start spawning monsters.
	$MonsterSpawnTimer.timeout.connect(spawn_monster)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse_click"):

		# Get where the player clicked.
		var mouse_position := get_global_mouse_position()

		# Convert the position into a tile coordinate.
		var cell = $Grass.local_to_map(mouse_position)

		# Check if there is a grass tile here.
		var tile_data = $Grass.get_cell_tile_data(cell)

		if tile_data == null:
			return

		# Don't allow two towers on the same tile.
		if cell in occupied_tiles:
			return

		# Remember that this tile now has a tower.
		occupied_tiles.append(cell)

		# Get the center of the tile.
		var tower_position = $Grass.map_to_local(cell)

		place_tower(tower_position)


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
