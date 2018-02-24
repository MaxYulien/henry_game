extends Node

const SAVE_PATH = "res://save.cfg"

var _config_file = ConfigFile.new()

func _ready():
	pass

func save_game(path):
	var saved_level = path
	_config_file.set_value("level","saved_level",saved_level)
	_config_file.save(SAVE_PATH)
	print("Succesfully saved to: " + String(SAVE_PATH))
	print("Saved Scene: " + String(saved_level))

func load_game():
	_config_file.load(SAVE_PATH)
	var loaded_level = _config_file.get_value("level","saved_level",null)
	get_node("/root/global").goto_scene(loaded_level)
	print("Succesfully loaded from: " + String(SAVE_PATH))
	print("Loaded Scene: " + String(loaded_level))