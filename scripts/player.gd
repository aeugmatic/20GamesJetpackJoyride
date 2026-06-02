extends CharacterBody2D

const MAX_Y_SPEED: float = 400.0
const Y_ACCEL: float = 2000.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_pressed("fly"):
		velocity.y += -Y_ACCEL * delta
	
	move_and_slide()
