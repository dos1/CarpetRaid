extends Sprite

# member variables here, example:
# var a=2
# var b="textvar"

var acc = 0

func _process(delta):
	self.acc += delta
	if self.acc < 0.1:
		return
	self.acc = 0
	var frame = self.get_frame() + 1
	if (frame>=self.get_hframes()):
		if (self.get_hframes() < 10):
			frame=0
		else:
			frame=self.get_hframes() - 1
	self.set_frame(frame)

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	self.set_process(true)
