
extends Sprite

# member variables here, example:
# var a=2
# var b="textvar"
var bullet = preload("res://Bullet.tscn")

func _process(delta):
	if (Input.is_action_pressed("move_left")):
		self.move_local_x(-200 * delta)
	if (Input.is_action_pressed("move_right")):
		self.move_local_x(200 * delta)
	if (Input.is_action_pressed("shoot")):
		var node = bullet.instance()
		self.get_parent().add_child(node)
		node.set_pos(self.get_pos())

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	self.set_process(true)
