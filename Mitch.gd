extends KinematicBody2D

const SPEED := 20

func get_velocity() -> Vector2:
	# Detect up/down/left/right keystate and only move when pressed.
	var velocity = Vector2()
	if Input.is_key_pressed(KEY_RIGHT):
		velocity.x += 1
	if Input.is_key_pressed(KEY_LEFT):
		velocity.x -= 1
	if Input.is_key_pressed(KEY_DOWN):
		velocity.y += 1
	if Input.is_key_pressed(KEY_UP):
		velocity.y -= 1
	velocity = velocity.normalized() * SPEED
	return velocity


func animate(velocity: Vector2):
		if velocity.x > 0: 
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.play("walk_side")
		if velocity.x < 0: 
			$AnimatedSprite.flip_h = true
			$AnimatedSprite.play("walk_side")
		if velocity.y > 0: 
			$AnimatedSprite.play("walk_south")
		if velocity.y < 0: 
			$AnimatedSprite.play("walk_north")
		if velocity == Vector2.ZERO:
			if $AnimatedSprite.animation == "walk_south":
				$AnimatedSprite.play("idle_south")
			if $AnimatedSprite.animation == "walk_north":
				$AnimatedSprite.play("idle_north")
			if $AnimatedSprite.animation == "walk_side":
				$AnimatedSprite.play("idle_side")


func _physics_process(delta):
	var velocity = get_velocity()
	move_and_collide(velocity * delta)
	animate(velocity)


func _on_Area2D_body_entered(body):
	GameEvents.emit_signal("mitch_close_to_note")


func _on_Area2D_body_exited(body):
	GameEvents.emit_signal("mitch_far_from_note")
