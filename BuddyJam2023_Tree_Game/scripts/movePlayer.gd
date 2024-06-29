extends Node

func movePlayer(direction):
	#print(get_stack());
	#print("Started at room: " + Global_Var.position);
	var newArr = Global_Var.position.rsplit("_");
	if(direction == 0):
		#print("move up")
		newArr[0] = str(int(newArr[0])+1);
	if(direction == 1):
		#print("move left")
		newArr[1] = str(int(newArr[1])-1);
	if(direction == 2):
		#print("move right")
		newArr[1] = str(int(newArr[1])+1);
	if(direction == 3):
		#print("move bottom")
		newArr[0] = str(int(newArr[0])-1);
	var newPos = "_".join(newArr);
	Global_Var.position = newPos;
	call_deferred("updatePos");
	#print("Entered new room: " + newPos);

func updatePos():
	var areaHolder = get_parent().get_node("AreaHolder");
	var newPos = Global_Var.map[Global_Var.position];
	areaHolder.get_child(0).queue_free(); #Remove the old area
	var newArea = load("res://scenes/areas/area_" + newPos + ".tscn");
	newArea = newArea.instantiate();
	var scale = Vector2(6,6);
	newArea.transform = newArea.transform.scaled(scale);
	#newArea.position.x += 575;
	#newArea.position.y += 325;
	#print("newPos: " + newPos);
	areaHolder.add_child(newArea); #Add the new area
