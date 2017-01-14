extends Node2D

func _input(event):
	if (event.type == InputEvent.KEY) and (event.pressed):
		if (event.scancode == KEY_ESCAPE):
			self.get_tree().set_input_as_handled()
			self.get_tree().quit()
		elif (event.scancode == KEY_F):
			self.get_tree().set_input_as_handled()
			OS.set_window_fullscreen(!OS.is_video_mode_fullscreen())

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	Globals.set('score', 0)
	Globals.set('lifes', 3)
	Globals.set('fuel', 100)
	self.set_process_input(true)
