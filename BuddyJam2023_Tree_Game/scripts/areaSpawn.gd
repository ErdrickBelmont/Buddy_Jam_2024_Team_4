extends Node2D

@onready var tile_map = $"."

#Number of rooms to be generated.
var numToGenerate = 8 + (2*Global_Var.stormCounter);
var numGenerated = 0;
var queue = []; #Rooms queued to add.
var spawnNode; #For generating actual bugs/trees

#Randomness shortcut
var rng = RandomNumberGenerator.new()

#Room arrays
var rightDoorRooms = ["center", "leftEdge", "leftUp", "leftBottom", "leftFork", "leftRight", "bottomFork", "topFork"];
var leftDoorRooms = ["center", "rightEdge", "rightUp", "rightBottom", "rightFork", "leftRight", "bottomFork", "topFork"];
var bottomDoorRooms = ["center", "topEdge", "topFork", "leftUp", "rightUp", "rightFork", "leftFork", "topBottom"];
var topDoorRooms = ["center", "bottomEdge", "bottomFork", "leftBottom", "rightBottom", "rightFork", "leftFork", "topBottom"];

#Dictionary of trees in each area. Each tree has an x, y, and state, corresponding to index 0, 1, 2 in the subarray.
#Basically, the key is the room code, and then the value is an array of 
var treeDict;

func _ready():
	#print(get_parent().get_parent().get_parent().get_children());
	#print(get_tree().root.get_node("Root_Node2D").get_node("RoomToRoom"));
	spawnNode = get_tree().root.get_node("Root_Node2D").get_node("RoomToRoom");
	#print(spawnNode)
	treeDict = Global_Var.treeDict;
	#Start with the center room. This is always an area_center type.
	if(Global_Var.newMapNeeded):
		Global_Var.map["0_0"] = "center";
		queue.append_array(["1_0", "0_-1", "0_1", "-1_0"])
		#Generate and place trees in center area
		generateTrees("0_0");
		generateMap();
		spawnNode.spawnTrees("0_0");
		spawnNode.shipCheck();
	#print(queue);
	Global_Var.newMapNeeded = false;
	
func generateMap():
	while(queue.size() > 0):
		var roomToAdd = queue.back();
		if(!Global_Var.map.has(roomToAdd) && roomToAdd != null): #Extra check because some were slipping through.
			#print(roomToAdd);
			addRoom(roomToAdd);
			generateTrees(roomToAdd);
			#print(Global_Var.treeDict);
		elif(roomToAdd != null):
			queue.erase(roomToAdd);
	
	
func addRoom(code):
	#Remove the area from the queue.
	queue.erase(code);
	#print("Code: ", code);
	#code is the name of the map area, ex: 0_0
	var areaPicked = null;
	numGenerated += 1;
	var roomOptions = [];
	#Determine what kind of gates it *needs* to have, as in, what rooms have already been generated that it's connecting to.
	if(hasNeighbor(code, 1)):
		roomOptions = leftDoorRooms;
	if(hasNeighbor(code, 2)):
		if(roomOptions == []):
			roomOptions = rightDoorRooms;
		else:
			roomOptions = arrIntersect(roomOptions, leftDoorRooms);
	if(hasNeighbor(code, 0)):
		if(roomOptions == []):
			roomOptions = topDoorRooms;
		else:
			roomOptions = arrIntersect(roomOptions, bottomDoorRooms);
	if(hasNeighbor(code, 3)):
		if(roomOptions == []):
			roomOptions = bottomDoorRooms;
		else:
			roomOptions = arrIntersect(roomOptions, topDoorRooms);
	#print(numToGenerate);
	#print(queue)
	while(areaPicked == null || Global_Var.areas[areaPicked].size() >= (numToGenerate-numGenerated-queue.size())):
		var randValue = rng.randi_range(0, roomOptions.size()-1);
		#print(randValue)
		areaPicked = roomOptions[randValue]
		#Edge case: Not enough rooms generated but the queue is empty. We can't hit a dead end
		if(Global_Var.areas[areaPicked].size() == 1 && queue.size() == 0 && numGenerated < numToGenerate):
			areaPicked == null;
	#Area has been selected. Add it to the map!
	Global_Var.map[code] = areaPicked;
	#print("Room type picked: " + areaPicked);
	
	#Add its neighbors to the queue if it has more than one gate.
	if(Global_Var.areas[areaPicked].size() > 1):
		var splitCode = code.rsplit("_");
		#Add area to the left to the queue if it's not already in it OR in the map.
		if(leftDoorRooms.has(areaPicked)):
			var leftArr = splitCode.duplicate();
			leftArr[1] = str(int(leftArr[1]) - 1);
			var leftCode = "_".join(leftArr);
			#print("Left neighbor added to queue: " + leftCode);
			#If it's not in the map or queue, add it to the queue with code as previous.
			if(!Global_Var.map.has(leftCode) && !queue.has(leftCode)):
				queue.append(leftCode);
		#Add area to the right.
		if(rightDoorRooms.has(areaPicked)):
			var rightArr = splitCode.duplicate();
			rightArr[1] = str(int(rightArr[1]) + 1);
			var rightCode = "_".join(rightArr);
			#print("Right neighbor added to queue: " + rightCode);
			#If it's not in the map or queue, add it to the queue with code as previous.
			if(!Global_Var.map.has(rightCode) && !queue.has(rightCode)):
				queue.append(rightCode);
		#Add area to the top.
		if(topDoorRooms.has(areaPicked)):
			var topArr = splitCode.duplicate();
			topArr[0] = str(int(topArr[0]) + 1);
			var topCode = "_".join(topArr);
			#print("Top neighbor added to queue: " + topCode);
			#If it's not in the map or queue, add it to the queue with code as previous.
			if(!Global_Var.map.has(topCode) && !queue.has(topCode)):
				queue.append(topCode);
		#Add area to the bottom.
		if(bottomDoorRooms.has(areaPicked)):
			var bottomArr = splitCode.duplicate();
			bottomArr[0] = str(int(bottomArr[0]) - 1);
			var bottomCode = "_".join(bottomArr);
			#print("Bottom neighbor added to queue: " + bottomCode);
			#If it's not in the map or queue, add it to the queue with code as previous.
			if(!Global_Var.map.has(bottomCode) && !queue.has(bottomCode)):
				queue.append(bottomCode);
	
#Return whether a room has a neighbor in the given direction. True or false.
func hasNeighbor(room, direction):
	#0=up, 1=left, 2=right, 3=down
	var roomArr = room.rsplit("_");
	var neighborArr = roomArr.duplicate();
	if(direction == 0): #above: +1 to Y
		neighborArr[0] = str(int(neighborArr[0])+1);
	if(direction == 1): #left: -1 to X
		neighborArr[1] = str(int(neighborArr[1])-1);
	if(direction == 2): #right: +1 to X
		neighborArr[1] = str(int(neighborArr[1])+1);
	if(direction == 3): #below: -1 to Y
		neighborArr[0] = str(int(neighborArr[0])-1);
	var neighborCode = "_".join(neighborArr);
	#Check
	if(Global_Var.map.has(neighborCode)):
		var neighborRoom = Global_Var.map[neighborCode]; #Imagine 0_0 (neighborCode) vs "center" (neighborRoom).
		if(direction == 0 && Global_Var.areas[neighborRoom].has("bottom")):
			return true;
		if(direction == 1 && Global_Var.areas[neighborRoom].has("right")):
			return true;
		if(direction == 2 && Global_Var.areas[neighborRoom].has("left")):
			return true;
		if(direction == 3 && Global_Var.areas[neighborRoom].has("top")):
			return true;
	#All hope has been lost, return false
	return false;

#Return array of the elements contained by both arr1 & arr2
func arrIntersect(arr1, arr2):
	var intersection = [];
	for arrItem in arr1:
		if arr2.has(arrItem):
			intersection.append(arrItem);
	return intersection;

#Generates trees
func generateTrees(code):
	#print("Code: ", code);
	if(treeDict.has(code)): #Don't overwrite any trees! Edge case.
		return;
	treeDict[code] = [];
	#Determine number of trees to place in each area, from 3 to 8
	var treesToGenerate = rng.randi_range(3, 8);
	var x;
	var y;
	var attempts = 0;
	while(treeDict[code].size() < treesToGenerate):
		if(rng.randi_range(0,1) == 0): #Place on left side of map
			if(Global_Var.position == "0_0"):
				x = rng.randi_range(-5600, -2475)
			else:
				x = rng.randi_range(-5600, -1550)
		else: #Place on right side
			if(Global_Var.position == "0_0"):
				x = rng.randi_range(3360, 5600)
			else:
				x = rng.randi_range(1550, 5600)
		if(rng.randi_range(0,1) == 0): #Place on top half of map
			y = rng.randi_range(-3400,-1750)
		else: #Place on bottom half
			y = rng.randi_range(1750, 2500)
		if(!treeIntersection(code, x, y)):
			var treeType = rng.randi_range(0, 0);
			treeDict[code].append([x, y, treeType]);
			attempts = 0;
		else:
			attempts += 1;
			if(attempts > 500):
				#Reshuffle trees. Prevents infinite loops
				treesToGenerate = rng.randi_range(3, 8);
				treeDict[code] = [];
	Global_Var.treeDict[code] = treeDict[code];
	
#Checks if the tree overlaps with another tree.
#Each tree is 1584 wide and 1326 tall.
#Returns true if the xy intersects with another tree, false if not
func treeIntersection(code, x, y):
	for tree in treeDict[code]:
		var treeX = tree[0];
		var treeY = tree[1];
		if(abs(treeX-x) < 1584 && abs(treeY-y) < 1326):
			return true;
	return false;
	
