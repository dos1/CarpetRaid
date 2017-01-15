
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
var bullet = preload("res://Bullet.tscn")

var SPEED = 200
var FUEL_DISCHARGE_SPEED = 0.5

var pressed = false

var current_level = 0

func _process(delta):
	if not Globals.get("started"):
		return
	if (Input.is_action_pressed("move_left")):
		self.move_local_x(-1 * SPEED * delta)
	if (Input.is_action_pressed("move_right")):
		self.move_local_x(SPEED * delta)
	if (Input.is_action_pressed("shoot")) and not self.pressed:
		if not self.get_parent().has_node("Bullet"):
			var node = bullet.instance()
			node.add_to_group("bullets")
			self.get_parent().add_child(node)
			node.set_z(15)
			node.set_pos(self.get_pos() + Vector2(-4, -50))
			if (randi()%2):
				self.get_node("ShotPlayer").play("shot1")
			else:
				self.get_node("ShotPlayer").play("shot2")
	self.pressed = Input.is_action_pressed("shoot")
	Globals.set('fuel', Globals.get('fuel') - FUEL_DISCHARGE_SPEED)
	if Globals.get('fuel') <= 0:
		self.lose()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	self.set_z(1)
	self.set_process(true)
	self.set_process_input(true)
	self.get_node("Area2D").add_to_group("player")

func lose():
	#return
	Globals.set('lifes', Globals.get('lifes')-1)
	self.set_pos(Vector2(1920/2, self.get_pos().y))
	self.get_parent().get_node("Stage").reload(current_level)
	Globals.set('fuel', 1000)
	if Globals.get('lifes') < 0:
		current_level = 0
		self.get_parent().get_node("Stage").reload(0)
		self.get_parent().get_node("Stage").stop()


func _on_Area2D_area_enter( area ):
	print(area, area.get_groups())
	if area.is_in_group("edge") or area.is_in_group("enemies") or area.is_in_group("bridge"):
		self.lose()
	if area.is_in_group("checkpoint"):
		current_level = int(area.get_name())-1
