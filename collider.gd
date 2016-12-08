extends Area2D

# member variables here, example:
# var a=2
# var b="textvar"

func _on_Area2D_area_enter(node):
	node.queue_free()
	self.set_pos(Vector2(rand_range(100, 900), rand_range(50, 450)))
	self.get_node("../BoomPlayer").play("boom")

func _process(delta):
	self.set_rot(self.get_rot() + 0.05)
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
	self.set_z(10)
	self.set_process(true)
	self.set_process_input(true)

