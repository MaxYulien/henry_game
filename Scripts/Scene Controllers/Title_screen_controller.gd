extends Node

var level_one = "res://Scenes/Levels/Prologue/Prologue_1.tscn"

func _ready():
	pass

func _on_New_Game_pressed():
	get_node("/root/global").goto_scene(level_one)

func _on_Load_Game_pressed():
	save_game.load_game()
