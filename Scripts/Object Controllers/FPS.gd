extends Label

func _ready():
	pass

func _process(delta):
	text = "FPS: " + String(Performance.get_monitor(Performance.TIME_FPS))