
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"
var enemy = preload("res://Enemy.tscn")
var level1 = preload("res://level1.tscn")
var level2 = preload("res://level2.tscn")
var level3 = preload("res://level3.tscn")
var levels = [level1, level2, level3]
var current_level = 1
var bridge = preload("res://Bridge.tscn")
var SPEED = 100
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
		modifier = 0.75
	
	self.move_local_y(SPEED * delta * modifier)
	self.get_parent().get_node("Background").move_local_y(SPEED * delta * modifier + SPEED * delta * 0.5)
	
	counter -= delta
	if counter < 0:
		#addEnemy()
		counter = 1.5
	
	#print(self.get_pos().y, self.get_item_and_children_rect().size.height - 1080)
	
	if self.get_pos().y - self.get_item_and_children_rect().size.height + 1080 + 400 >=0:
		var node = levels[current_level % 3].instance()
		self.add_child(node)
		node.set_pos(Vector2(0, -self.get_item_and_children_rect().size.height + 400))
		
		var b = bridge.instance()
		node.add_child(b)
		bridge.set_name(str(current_level))
		b.set_pos(Vector2(1920/2, node.get_item_and_children_rect().size.height - 1350))
		current_level+=1
		
	#print("cleanup")
	for child in self.get_children():
		#print(self.get_pos().y + child.get_pos().y)
		if self.get_pos().y + child.get_pos().y > child.get_item_and_children_rect().size.height + 1000:
			print("freeing", child)
			child.queue_free()

func reload(level):
	for child in self.get_children():
		child.queue_free()
	self.set_pos(Vector2(0,0))
	var node = levels[level % 3].instance()
	self.add_child(node)
	current_level = level + 1

func restart():
	self.reload(current_level - 1)

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	#addEnemy()
	reload(0)
	self.set_process(true)