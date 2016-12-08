extends Node2D

func _input(event):
	if (event.type == InputEvent.KEY):
		if (event.scancode == KEY_ESCAPE):
			self.get_tree().set_input_as_handled()
			self.get_tree().quit()
		elif (event.scancode == KEY_F):
			get_node("Plane/ShotPlayer").play("shot1");
			OS.set_window_fullscreen(!OS.is_video_mode_fullscreen())

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	self.set_process_input(true)
