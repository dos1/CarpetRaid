
extends Sprite

# member variables here, example:
# var a=2
# var b="textvar"

var acc = 0

func _on_ToolButton_pressed():
	var frame = self.get_frame() + 1
	if (frame>3):
		frame=0
	self.set_frame(frame)
	
	self.set_pos(Vector2(rand_range(200, 800), rand_range(100, 500)))
	
func _process(delta):
	self.set_rot(self.get_rot() + 0.05)
	self.acc += delta
	if self.acc < 0.2:
		return
	self.acc = 0
	var frame = self.get_frame() + 1
	if (frame>3):
		frame=0
	self.set_frame(frame)
	#if(Input.is_key_pressed(KEY_ESCAPE)):
    #     get_tree().quit()

func _input(event):
	if (event.type == InputEvent.KEY):
		if (event.scancode == KEY_ESCAPE):
			self.get_tree().set_input_as_handled()
			self.get_tree().quit()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	add_to_group("enemies")
	randomize()
	self.set_process(true)
	self.set_process_input(true)

