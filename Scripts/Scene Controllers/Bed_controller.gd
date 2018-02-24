extends Area2D

var player_spawned = false

signal spawn_player

func _ready():
	$AnimatedSprite.play("bed_1")

func _process(delta):
	if Input.is_action_just_pressed("jump") and !player_spawned:
		emit_signal("spawn_player")
		player_spawned = true
		$AnimatedSprite.play("bed_2")