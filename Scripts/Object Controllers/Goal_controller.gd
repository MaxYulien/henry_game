extends Area2D

export (String) var warp_to

func _ready():
	pass

func _on_Goal_body_entered( body ):
	if body.is_in_group("player"):
		get_node("/root/global").goto_scene(warp_to)
