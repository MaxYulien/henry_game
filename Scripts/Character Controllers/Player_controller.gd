extends KinematicBody2D

var floor_normal = Vector2(0,-1)
var velocity = Vector2()
var aim_direction = Vector2(1,0)

var gravity = 3000
var jump_force = 1000
var on_air_jumps = 1
var direction = 1

var acceleration = 50
var max_speed = 400

var speed_x = 0
var speed_y = 0

var grounded = false
var can_shoot = true
var player_lock = false

var bullet = load("res://Scenes/Objects/Bullet.tscn")

signal fire
signal player_died

func _ready():
	show()

func _physics_process(delta):
	
	var move_up = Input.is_action_pressed("move_up")
	var move_down = Input.is_action_pressed("move_down")
	var move_left = Input.is_action_pressed("move_left")
	var move_right = Input.is_action_pressed("move_right")
	var jump = Input.is_action_just_pressed("jump")
	var jump_release = Input.is_action_just_released("jump")
	var shoot = Input.is_action_pressed("shoot")
	var locked = Input.is_action_pressed("move_lock") and grounded
	
	if grounded:
		if speed_x == 0:
			$Henry_img.play("Henry_unarmed_idle")
		else:
			$Henry_img.play("Henry_unarmed_run")
	else:
		if speed_y < 0:
			$Henry_img.play("Henry_unarmed_jump")
		elif speed_y > 0:
			$Henry_img.play("Henry_unarmed_fall")
	
	if !player_lock:
		if is_on_floor():
			speed_y = 0
			on_air_jumps = 1
			grounded = true
		else:
			grounded = false
		
		if is_on_ceiling():
			speed_y = 0
		
		speed_y += delta * gravity
		
		if move_right and !locked:
			speed_x += acceleration
			if speed_x > max_speed:
				speed_x = max_speed
		elif move_left and !locked:
			speed_x += -acceleration
			if speed_x < -max_speed:
				speed_x = -max_speed
		else:
			speed_x = 0
		
		if move_right:
			direction = 1
			$Henry_img.flip_h = false
		elif move_left:
			direction = -1
			$Henry_img.flip_h = true
		
		if jump:
			if grounded:
				speed_y = -jump_force
			elif !grounded and on_air_jumps > 0:
				speed_y = -jump_force
				on_air_jumps -= 1
		elif jump_release and speed_y < 0:
			speed_y = 0
		
		velocity.x = speed_x
		velocity.y = speed_y
		
		move_and_slide(velocity,floor_normal)
		
		if move_up:
			if move_right or move_left:
				aim_direction.x = direction
			else:
				aim_direction.x = 0
			aim_direction.y = -1
		elif move_down:
			if move_right or move_left:
				aim_direction.x = direction
			else:
				aim_direction.x = 0
			aim_direction.y = 1
		else:
			aim_direction.x = direction
			aim_direction.y = 0
		
		if shoot and can_shoot:
			emit_signal("fire")
			can_shoot = false
			$Shoot_cooldown.start()
	else:
		speed_y += delta * gravity
		velocity.x = speed_x
		velocity.y = speed_y
		move_and_slide(velocity,floor_normal)
		
		if is_on_floor():
			speed_x = 0
			speed_y = 0

func _on_Shoot_cooldown_timeout():
	can_shoot = true

func _on_Hit_detection_area_entered( area ):
	if area.is_in_group("obstacles"):
		hide()
		player_lock = true
		emit_signal("player_died")
