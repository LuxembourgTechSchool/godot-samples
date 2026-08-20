extends CharacterBody2D

## variables for pickup and dropoff
var objects_in_range : Array[Node2D] = []
var object_to_pick_up : Node2D
@onready var hand_position: Marker2D = $HandPosition
@onready var drop_off_position: Marker2D = $DropOffPosition
var original_parent : Node
var carrying:bool = false
var carried_object : Node2D


func _physics_process(delta: float) -> void:
	##simple movement
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direction * 600
	move_and_slide()
	
	##check for pick up and drop off
	if !carrying:
		object_to_pick_up = get_closest_object()
		pickupObject()
	else:
		dropObject()

##pick up an object
func pickupObject() -> void:
		if Input.is_action_just_pressed("pickup") && !carrying && object_to_pick_up:
			original_parent = object_to_pick_up.get_parent()
			object_to_pick_up.reparent(hand_position)
			object_to_pick_up.global_position = hand_position.global_position
			carrying = true
			carried_object = object_to_pick_up

##drop an object
func dropObject() -> void:
		if Input.is_action_just_pressed("pickup") && carrying:
			carried_object.reparent(original_parent)
			carried_object.global_position = drop_off_position.global_position 
			carrying = false
			carried_object = null


## check if pickable objects are in range 
func _on_pickup_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("pickable"):
		if not objects_in_range.has(body):
			objects_in_range.append(body)

##check if pickable objects leave the range
func _on_pickup_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("pickable"):
		objects_in_range.erase(body)

##find the closest object of those in range
func get_closest_object() -> Node2D:
	var closest_object: Node2D = null
	var closest_distance: float = INF
	
	for object in objects_in_range:
		
		var distance = hand_position.global_position.distance_to(object.global_position)
		
		if distance < closest_distance:
			closest_distance = distance
			closest_object = object
	
	return closest_object
