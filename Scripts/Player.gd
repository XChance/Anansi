extends CharacterBody2D

const SPEED = 180.0
const JUMP_VELOCITY = -400.0

const grav_modifier = 1

var spaceRelease = false

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		if Input.is_action_just_released("up") and !spaceRelease:
			velocity.y = 0
			spaceRelease = true
		velocity += get_gravity() * delta * grav_modifier
	else:
		spaceRelease = false

	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY


	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	if velocity.x != 0:
		$AnimatedSprite2D.scale.x = 1 if velocity.x < 0 else -1
