extends Area2D

# member variables here, example:
# var a=2
# var b="textvar"

var acc = 0

func _on_Area2D_area_enter(body):
	if body.is_in_group("bullets"):
		body.queue_free()
		self.queue_free()
		Globals.set('score', Globals.get('score')+self.get_parent().get_parent().get_score())
		#self.set_pos(Vector2(rand_range(100, 1800), rand_range(50, 750)))
		self.get_node("../../BoomPlayer").play("boom")

	if body.is_in_group("player"):
		self.queue_free()
		#self.set_pos(Vector2(rand_range(100, 1800), rand_range(50, 750)))
		self.get_node("../../BoomPlayer").play("boom")

	if body.is_in_group("edge"):
		self.get_parent().get_parent().mirror()
		return

func _process(delta):
	#self.set_rot(self.get_rot() + 0.05)
	self.acc += delta
	if self.acc >= 0.1:
		self.acc -= 0.1
		var frame = self.get_node("Sprite").get_frame() + 1
		if (frame>self.get_node("Sprite").get_hframes()-1):
			frame=0
		self.get_node("Sprite").set_frame(frame)

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	add_to_group("enemies")
	randomize()
	self.set_z(10)
	self.set_process(true)
