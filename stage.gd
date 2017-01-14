
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
var enemy = preload("res://Enemy.tscn")
var level1 = preload("res://level1.tscn")
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
		#addEnemy()
		counter = 1.5
	
	if self.get_pos().y - self.get_item_and_children_rect().size.height + 1500 >=0:
		var node = level1.instance()
		self.add_child(node)
		node.set_pos(Vector2(0, -self.get_item_and_children_rect().size.height + 200))

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	#addEnemy()
	self.set_process(true)


