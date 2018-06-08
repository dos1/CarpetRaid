extends Node2D

var old_score = 0

func _input(event):
	if (event.type == InputEvent.KEY) and (event.pressed):
		if (event.scancode == KEY_ESCAPE):
			self.get_tree().set_input_as_handled()
			self.get_tree().quit()
		elif (event.scancode == KEY_F):
			self.get_tree().set_input_as_handled()
			OS.set_window_fullscreen(!OS.is_video_mode_fullscreen())

func _process(delta):
	var score = Globals.get('score')
	if int(score/2000) > int(self.old_score/2000):
		Globals.set('lifes', Globals.get('lifes')+1)
	self.old_score = score
	
	var fuel = Globals.get('fuel')
	if fuel > 1000:
		fuel = 1000
	if fuel < 0:
		fuel = 0
	Globals.set('fuel', fuel)
	
	if fuel < 300:
		self.get_node("SamplePlayer").play("beep", true)
	
func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	self.set_process_input(true)
	self.set_process(true)
