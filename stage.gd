
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
var enemy = preload("res://Enemy.tscn")
var SPEED = 200

var counter = -1

func addEnemy():
	var node = enemy.instance()
	self.add_child(node)
	node.set_moving(randi()%2)
	node.set_facing_left(randi()%2)
	node.set_pos(Vector2(1920/2, -self.get_pos().y - 100))

func _process(delta):
	self.move_local_y(SPEED * delta)
	counter -= delta
	if counter < 0:
		addEnemy()
		counter = 1

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	#addEnemy()
	self.set_process(true)


