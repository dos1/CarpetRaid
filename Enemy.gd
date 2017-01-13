
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

var SPEED = 200

export(String, "Rocket", "Boatie", "Boat", "Helicopter") var type
export var moving = true
export var left = true
export var contained = true

func _process(delta):
	if self.moving:
		if self.left:
			self.move_local_x(-1*SPEED*delta)
		else:
			self.move_local_x(1*SPEED*delta)
			
	if not self.contained:
		if self.get_pos().x < -50:
			self.set_pos(Vector2(1960, self.get_pos().y))
		if self.get_pos().x > 1970:
			self.set_pos(Vector2(-40, self.get_pos().y))

func set_contained(con):
	self.contained = con

func set_type(type):
	self.type = type
	for child in self.get_node("Sprites").get_children():
		if child.get_name()!=type:
			child.free()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	self.set_type(self.type)
	self.set_facing_left(self.left)
	self.set_process(true)

func set_moving(moving):
	self.moving = moving
	
func set_facing_left(left):
	self.left = left
	if not left:
		self.get_node("Sprites").set_scale(Vector2(-1,1))
	else:
		self.get_node("Sprites").set_scale(Vector2(1,1))
		
func mirror():
	if not self.contained:
		return
	self.set_facing_left(not self.left)
	if self.left:
		self.move_local_x(-1*SPEED*0.2)
	else:
		self.move_local_x(1*SPEED*0.2)