
extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var texture = preload("res://tloziemia2_960.png")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	#print(self.get_children())
	texture.set_flags(Texture.FLAG_REPEAT)
	
	self.add_to_group("edge")
	
	for child in self.get_children():
		var rect = Polygon2D.new()
		rect.set_polygon(child.get_polygon())
		rect.set_pos(child.get_pos())
		rect.set_texture(texture)
		self.add_child(rect)
	
#	self.get_node("Polygon").set_polygon(self.get_node("CollisionPolygon2D").get_polygon())#
	#self.get_node("Polygon").set_pos(self.get_node("CollisionPolygon2D").get_pos())
	#print(self.get_children())
	#self.clear_shapes()
	#self.get_node("Collider")._add_to_collision_object(self)
	
	#print(self.get_node("Collider").get_children())
	#var shape = ConvexPolygonShape2D.new()
	#var poly = self.get_node("Polygon2D").get_polygon()
	#for i in range(0, poly.size()):
	#	poly[i] = poly[i] + self.get_node("Polygon2D").get_pos()
		
	#shape.set_points(poly)
	#self.clear_shapes()
	#self.add_shape(shape)

	#self.get_node("Collider").set_shape(shape)
			#self.get_node("Collider").set_polygon(poly)

func _on_Area2D_area_enter( area ):
	pass
	#print("edge: ", area)
