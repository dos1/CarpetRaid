extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var BRIDGE_POINTS = 500

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	self.get_node("Area2D").add_to_group("bridge")
	pass


func _on_Area2D_area_enter( area ):
	if area.is_in_group("bullets"):
		area.queue_free()
		self.queue_free()
		Globals.set('score', Globals.get('score')+BRIDGE_POINTS)
		#self.set_pos(Vector2(rand_range(100, 1800), rand_range(50, 750)))
		#self.get_node("../../BoomPlayer").play("boom")

