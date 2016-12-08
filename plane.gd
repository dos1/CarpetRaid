
extends Sprite

# member variables here, example:
# var a=2
# var b="textvar"
var bullet = preload("res://Bullet.tscn")

var acc = 0
var cooldown = 0

var SPEED = 400

func _process(delta):
	if (Input.is_action_pressed("move_left")):
		self.move_local_x(-1 * SPEED * delta)
	if (Input.is_action_pressed("move_right")):
		self.move_local_x(SPEED * delta)
	if (Input.is_action_pressed("shoot")):
		if (cooldown <= 0):
			var node = bullet.instance()
			self.get_parent().add_child(node)
			node.set_z(0)
			node.set_pos(self.get_pos() + Vector2(-4, -50))
			if (randi()%2):
				self.get_node("ShotPlayer").play("shot1")
			else:
				self.get_node("ShotPlayer").play("shot2")
			#cooldown = 0.1
		cooldown = 0.1
	else:
		cooldown = 0
	cooldown -= delta
		
	self.acc += delta
	if self.acc >= 0.1:
		self.acc -= 0.1
		var frame = self.get_frame() + 1
		if (frame>3):
			frame=0
		self.set_frame(frame)


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
	self.set_z(1)
	self.set_process(true)
	self.set_process_input(true)
