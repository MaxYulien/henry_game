extends Area2D

var direction = Vector2()
var speed = 600

func _ready():
	pass

func _process(delta):
	position += direction * speed * delta

func _on_Bullet_body_entered( body ):
	if !body.is_in_group("player"):
		queue_free()

func _on_Timer_timeout():
	queue_free()
