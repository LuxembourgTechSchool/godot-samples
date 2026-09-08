class_name Bird extends CharacterBody2D

@export var gravity: int = 1000
@export var max_velocity: int = 600
@export var flap_speed: int = -500

var flying: bool = false
var falling: bool = false

const start_pos = Vector2(100, 400)

func _ready() -> void:
	reset()


func _physics_process(delta: float) -> void:
	if flying or falling:
		velocity.y += gravity * delta;
		
		if velocity.y > max_velocity:
			velocity.y = max_velocity
			
		if flying:
			set_rotation(deg_to_rad(velocity.y * 0.05))
			$AnimatedSprite2D.play()
		elif falling:
			set_rotation(PI/2)
			$AnimatedSprite2D.stop()
		move_and_collide(velocity * delta)
	else:
		$AnimatedSprite2D.stop()

func flap() -> void:
	velocity.y = flap_speed

func reset() -> void:
	falling = false
	flying = false
	position = start_pos
	set_rotation(0)
	
