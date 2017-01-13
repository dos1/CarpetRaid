
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
var enemy = preload("res://Enemy.tscn")
var SPEED = 150
var ENEMIES = ["Helicopter", "Rocket", "Boatie", "Boat"]

var counter = -1

func addEnemy():
	var node = enemy.instance()
	var type = ENEMIES[randi()%4]
	node.set_type(type)
	node.set_moving(randi()%2)
	node.set_facing_left(randi()%2)
	node.set_contained(true)
	if type=="Rocket":
		node.set_contained(false)
		node.set_moving(true)
	node.set_pos(Vector2(1920/2, -self.get_pos().y - 100))
	self.add_child(node)

func _process(delta):
	var modifier = 1
	if Input.is_action_pressed("move_fast"):
		modifier = 1.5
	if Input.is_action_pressed("move_slow"):
		modifier = 0.5
	
	self.move_local_y(SPEED * delta * modifier)
	counter -= delta
	if counter < 0:
		addEnemy()
		counter = 1.5

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	#addEnemy()
	self.set_process(true)


