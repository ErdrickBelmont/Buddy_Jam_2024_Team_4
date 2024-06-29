extends Area2D

var d := 0.0
var radius := 150.0
var speed := 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(get_global_mouse_position())
	print(get_relative_transform_to_parent($"/root/Root_Node2D/CharacterBody2D/charCollider"))
	#set_position(get_local_transform())
	#(Vector2(get_relative_transform_to_parent($"/root/Root_Node2D/CharacterBody2D/charCollider")))
	#var temp1: float = get_global_mouse_position().x
	#var temp2: float = get_global_mouse_position().y
	#var parentPosition: Vector2 = get_node("/root/Root_Node2D/CharacterBody2D/charCollider").position
	#position = Vector2(sin(temp1),cos(temp2)) + Vector2(parentPosition.x +100, parentPosition.y + 100)
	#translate(get_relative_transform_to_parent($"/root/Root_Node2D/CharacterBody2D/charCollider"))
	pass
#E 0:00:01:0404   Area2D.gd:12 @ _process(): Node not found: "CharacterBody2D" (relative to "/root/Root_Node2D/CharacterBody2D/Area2D").
 # <C++ Error>    Method/function failed. Returning: nullptr
 # <C++ Source>   scene/main/node.cpp:1651 @ get_node()
 # <Stack Trace>  Area2D.gd:12 @ _process()
