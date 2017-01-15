extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var BRIDGE_POINTS = 500

var active = true

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	self.get_node("Area2D").add_to_group("bridge")

func _on_Area2D_area_enter( area ):
	if active and area.is_in_group("bullets"):
		area.queue_free()
		#self.queue_free()
		self.hide()
		self.get_node("Area2D").remove_from_group("bridge")
		self.get_node("Area2D").add_to_group("checkpoint")
		Globals.set('score', Globals.get('score')+BRIDGE_POINTS)
		#self.set_pos(Vector2(rand_range(100, 1800), rand_range(50, 750)))
		#self.get_node("../../BoomPlayer").play("boom")
		self.active = false

