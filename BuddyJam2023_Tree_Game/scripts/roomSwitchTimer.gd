extends Timer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_timeout():
	Global_Var.moveCooldown = true;
