
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
var enemy = preload("res://Enemy.tscn")
var SPEED = 200
var ENEMIES = ["Helicopter", "Rocket", "Boatie", "Boat"]

var counter = -1

func addEnemy():
	var node = enemy.instance()
	node.set_type(ENEMIES[randi()%4])
	node.set_moving(randi()%2)
	node.set_facing_left(randi()%2)
	node.set_pos(Vector2(1920/2, -self.get_pos().y - 100))
	self.add_child(node)

func _process(delta):
	self.move_local_y(SPEED * delta)
	counter -= delta
	if counter < 0:
		addEnemy()
		counter = 2

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	#addEnemy()
	self.set_process(true)


