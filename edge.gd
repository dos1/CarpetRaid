extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	self.add_to_group("edge")


func _on_Area2D_body_enter( body ):
	pass
	#body.queue_free() # replace with function body
