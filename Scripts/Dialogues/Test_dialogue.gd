extends CanvasLayer

var page = 0

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("jump"):
		page += 1
	
	if page == 0:
		$Line_1.show()
		$Face.play("Henry_speaking_neutral")
	elif page == 1:
		$Line_1.hide()
		$Line_2.show()
		$Face.play("Henry_silent_neutral")
	elif page == 2:
		$Line_2.hide()
		$Line_3.show()
		$Face.play("Henry_speaking_neutral")
	else:
		queue_free()
