extends Node

var areaHolder;

func _ready():
	#For moving the player room-to-room.
	areaHolder = get_parent().get_node("AreaHolder");

func movePlayer(direction):
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
	var newPos = Global_Var.map[Global_Var.position];
	print(get_children());
	for node in get_children():
		#print(node);
		remove_child(node);
		node.queue_free();
	areaHolder.get_child(0).queue_free(); #Remove the old area
	var newArea = load("res://scenes/areas/area_" + newPos + ".tscn");
	newArea = newArea.instantiate();
	var scale = Vector2(6,6);
	newArea.transform = newArea.transform.scaled(scale);
	#newArea.position.x += 575;
	#newArea.position.y += 325;
	#print("newPos: " + newPos);
	areaHolder.add_child(newArea); #Add the new area
	spawnTrees(Global_Var.position);
	
func spawnTrees(code):
	var treeScene = load("res://scenes/Choppable_Tree.tscn");
	#print(Global_Var.treeDict)
	if(!Global_Var.treeDict.has(code)):
		#print("Lost")
		return;
	for tree in Global_Var.treeDict[code]:
		var instance = treeScene.instantiate();
		add_child(instance);
		instance.position.x = tree[0];
		instance.position.y = tree[1];
		var sprite = instance.get_node("sprite"); #is a tilemap cell
		#print(sprite.get_cell_source_id(0, Vector2(-1, -1)))
		sprite.set_cell(0, Vector2(-1, -1), 1, Vector2(tree[2], 0)); #tree[2] is set to the coord 0/1/2 (full grown, different variants) or 3 (chopped) or 4 (fertilized)
		#print("Intantiated tree with x=" + str(tree[0]) + ", y=" + str(tree[1]) + ", and sprite" + str(tree[2]));
	#print("Kids");
	#print(get_parent().get_children());
