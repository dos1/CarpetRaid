
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
var bullet = preload("res://Bullet.tscn")

var SPEED = 400

var pressed = false

func _process(delta):
	if (Input.is_action_pressed("move_left")):
		self.move_local_x(-1 * SPEED * delta)
	if (Input.is_action_pressed("move_right")):
		self.move_local_x(SPEED * delta)
	if (Input.is_action_pressed("shoot")) and not self.pressed:
		if not self.get_parent().has_node("Bullet"):
			var node = bullet.instance()
			node.add_to_group("bullets")
			self.get_parent().add_child(node)
			node.set_z(0)
			node.set_pos(self.get_pos() + Vector2(-4, -50))
			if (randi()%2):
				self.get_node("ShotPlayer").play("shot1")
			else:
				self.get_node("ShotPlayer").play("shot2")
	self.pressed = Input.is_action_pressed("shoot")
	Globals.set('fuel', Globals.get('fuel') - 1)

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	self.set_z(1)
	self.set_process(true)
	self.set_process_input(true)
	self.get_node("Area2D").add_to_group("player")

func _on_Area2D_area_enter( area ):
	print(area, area.get_groups())
	if area.is_in_group("edge") or area.is_in_group("enemies"):
		Globals.set('lifes', Globals.get('lifes')-1)
		self.set_pos(Vector2(1920/2, self.get_pos().y))
