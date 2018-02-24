extends Node

export (String) var current_scene

var is_player_dead = false

func _ready():
	save_game.save_game(current_scene)

func _process(delta):
	if Input.is_action_just_pressed("jump") and is_player_dead:
		get_node("/root/global").goto_scene(current_scene)

func _on_Player_fire():
	var b = $Player.bullet.instance()
	add_child(b)
	b.position = $Player.position
	b.direction = $Player.aim_direction

func _on_Player_player_died():
	is_player_dead = true
