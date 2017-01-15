tool
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

var SPEED = 100

export(String, "Rocket", "Boatie", "Boat", "Helicopter") var type setget set_type
export var moving = true
export var left = true setget set_facing_left
export var contained = true
export var speed_modifier = 1

var SPEED_MODIFIERS = {
  "Rocket": 3,
  "Boatie": 1,
  "Boat": 1,
  "Helicopter": 1
}

var POINTS = {
  "Rocket": 100,
  "Boatie": 100,
  "Boat": 100,
  "Helicopter": 100
}

var speed_type_modifier = 1

func _process(delta):
	if self.moving:
		if self.left:
			self.move_local_x(-1*SPEED*delta*speed_modifier*speed_type_modifier)
		else:
			self.move_local_x(1*SPEED*delta*speed_modifier*speed_type_modifier)
			
	if not self.contained:
		if self.get_pos().x < -50:
			self.set_pos(Vector2(1960, self.get_pos().y))
		if self.get_pos().x > 1970:
			self.set_pos(Vector2(-40, self.get_pos().y))

func set_contained(con):
	self.contained = con

func set_type(t):
	type = t
	if self.has_node("Sprites"):
		for child in self.get_node("Sprites").get_children():
			if child.get_name()!=type:
				if self.is_inside_tree() and not self.get_tree().is_editor_hint():
					child.free()
				else:
					child.set_opacity(0)
			else:
				child.set_opacity(1)
	speed_type_modifier = SPEED_MODIFIERS[t]

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	self.set_type(self.type)
	self.set_facing_left(self.left)
	if self.get_tree() and not self.get_tree().is_editor_hint():
		self.set_process(true)

func set_moving(moving):
	self.moving = moving
	
func get_score():
	return POINTS[self.type]
	
func set_facing_left(l):
	left = l
	if self.has_node("Sprites"):
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