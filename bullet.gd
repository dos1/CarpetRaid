
extends Area2D

# member variables here, example:
# var a=2
# var b="textvar"

var SPEED = 800

func _process(delta):
	self.move_local_y(-1 * SPEED * delta)

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	self.set_process(true)


