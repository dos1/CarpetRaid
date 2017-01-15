extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var active = false

var FUEL_RECHARGE_SPEED = 20
var FUEL_POINTS = 10

func _process(delta):
	if self.active:
		Globals.set('fuel', Globals.get('fuel') + FUEL_RECHARGE_SPEED)

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	self.add_to_group("fuel")
	self.set_process(true)

func _on_Area2D_2_area_enter( area ):
	if area.is_in_group("player"):
		print("GUL GUL GUL")
		self.active = true
		
	if area.is_in_group("bullets"):
		area.queue_free()
		self.queue_free()
		Globals.set('score', Globals.get('score')+FUEL_POINTS)
		#self.set_pos(Vector2(rand_range(100, 1800), rand_range(50, 750)))
		#self.get_node("../../BoomPlayer").play("boom")

	pass # replace with function body


func _on_Area2D_2_area_exit( area ):
	if area.is_in_group("player"):
		print("AHHHH")
		self.active = false
	pass # replace with function body
