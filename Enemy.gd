
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
var moving = true
var left = true

var SPEED = 200

func _process(delta):
	if self.moving:
		if self.left:
			self.move_local_x(-1*SPEED*delta)
		else:
			self.move_local_x(1*SPEED*delta)

func set_type(type):
	for child in self.get_node("Sprites").get_children():
		if child.get_name()!=type:
			child.free()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	self.set_process(true)

func set_moving(moving):
	self.moving = moving
	
func set_facing_left(left):
	self.left = left
	if not left:
		self.get_node("Sprites").set_scale(Vector2(-1,1))