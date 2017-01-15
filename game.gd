extends Node2D

func _input(event):
	if (event.type == InputEvent.KEY) and (event.pressed):
		if (event.scancode == KEY_ESCAPE):
			self.get_tree().set_input_as_handled()
			self.get_tree().quit()
		elif (event.scancode == KEY_F):
			self.get_tree().set_input_as_handled()
			OS.set_window_fullscreen(!OS.is_video_mode_fullscreen())

func _process(delta):
	var fuel = Globals.get('fuel')
	if fuel > 1000:
		fuel = 1000
	if fuel < 0:
		fuel = 0
	Globals.set('fuel', fuel)
	
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	Globals.set('score', 0)
	Globals.set('lifes', 3)
	Globals.set('fuel', 1000)
	self.set_process_input(true)
	self.set_process(true)
