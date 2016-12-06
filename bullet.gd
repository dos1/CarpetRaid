
extends Sprite

# member variables here, example:
# var a=2
# var b="textvar"

func _process(delta):
	self.move_local_y(-500 * delta)
	get_tree().call_group(0, "enemies", "bullet_moved", self.get_pos())

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	self.set_process(true)


