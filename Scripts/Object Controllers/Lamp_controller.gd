extends Area2D

var on = false
var touching = false

func _ready():
	$AnimatedSprite.play("lamp_1")

func _process(delta):
	if touching:
		if Input.is_action_just_pressed("move_up"):
			if on:
				$AnimatedSprite.play("lamp_1")
				on = false
			elif !on:
				$AnimatedSprite.play("lamp_2")
				on = true

func _on_Lamp_body_entered( body ):
	touching = true

func _on_Lamp_body_exited( body ):
	touching = false
