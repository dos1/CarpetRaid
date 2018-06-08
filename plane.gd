
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
var bullet = preload("res://Bullet.tscn")

var SPEED = 200
var FUEL_DISCHARGE_SPEED = 0.5

var pressed = false

var current_level = 0

var losing = false

var delay = 0

func _process(delta):
	
	if self.losing:
		delay += delta
		if self.delay > 0.5:
			self.delay = 0
			
			#self.get_node("Area2D/Sprite").set_frame(self.get_node("Area2D/Sprite").get_frame()+1)
			
			if self.get_node("Area2D/Sprite").get_frame() >= self.get_node("Area2D/Sprite").get_hframes() - 1:
				self.get_node("Area2D/Sprite").set_texture(preload("res://plane.png"));
				self.get_node("Area2D/Sprite").set_hframes(4)
	
				get_node("Area2D/CollisionPolygon2D").set_trigger(false)

				Globals.set('lifes', Globals.get('lifes')-1)
				self.set_pos(Vector2(1920/2, self.get_pos().y))
				self.get_parent().get_node("Stage").reload(current_level)
				Globals.set('fuel', 1000)
				if Globals.get('lifes') < 0:
					current_level = 0
					self.get_parent().get_node("Stage").reload(0)
					self.get_parent().get_node("Stage").stop()
					self.get_parent().get_node("SamplePlayer").stop_all()
					self.get_parent().get_node("SamplePlayer").play("fail")
					
				self.losing = false
			
		return
	
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
	if self.losing:
		return
	self.losing = true
	get_node("Area2D/CollisionPolygon2D").set_trigger(true)
	self.get_node("Area2D/Sprite").set_texture(preload("res://Gracz_d.png"));
	self.get_node("Area2D/Sprite").set_hframes(15)
	self.get_node("Area2D/Sprite").set_frame(0)
	self.get_parent().get_node("SamplePlayer").play("boom")

	#Globals.set('lifes', Globals.get('lifes')-1)
	#self.set_pos(Vector2(1920/2, self.get_pos().y))
	#self.get_parent().get_node("Stage").reload(current_level)
	#Globals.set('fuel', 1000)
	#if Globals.get('lifes') < 0:
	#	current_level = 0
	#	self.get_parent().get_node("Stage").reload(0)
	#	self.get_parent().get_node("Stage").stop()

func _on_Area2D_area_enter( area ):
	print(area, area.get_groups())
	if area.is_in_group("edge") or area.is_in_group("enemies") or area.is_in_group("bridge"):
		self.lose()
	if area.is_in_group("checkpoint"):
		current_level = int(area.get_name())-1
