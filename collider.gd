extends Area2D

# member variables here, example:
# var a=2
# var b="textvar"

func _on_Area2D_area_enter(node):
	node.queue_free()
	self.set_pos(Vector2(rand_range(100, 1800), rand_range(50, 750)))
	self.get_node("../BoomPlayer").play("boom")

func _process(delta):
	self.set_rot(self.get_rot() + 0.05)

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	add_to_group("enemies")
	randomize()
	self.set_z(10)
	self.set_process(true)
