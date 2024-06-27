extends Node

func movePlayer(direction):
	var newArr = Global_Var.position.rsplit("_");
	if(direction == 0):
		newArr[0] = str(int(newArr[0])+1);
	if(direction == 1):
		newArr[1] = str(int(newArr[0])-1);
	if(direction == 2):
		newArr[1] = str(int(newArr[0])+1);
	if(direction == 3):
		newArr[0] = str(int(newArr[0])-1);
	var newPos = "_".join(newArr);
	print(newPos);
	Global_Var.position = newPos;
	updatePos();

func updatePos():
	var areaHolder = get_tree().root.get_node("AreaHolder");
	var newPos = Global_Var.map[Global_Var.position];
	areaHolder.get_child(0).queue_free(); #Remove the old area
	get_tree().root.areaHolder.add_child("user://scenes/areas/area_" + newPos); #Add the new area
