extends Node2D

@onready var tile_map = $"."

#Number of rooms to be generated.
var numToGenerate = 8 + (2*Global_Var.stormCounter);
var numGenerated = 0;
var queue = []; #Rooms queued to add.

#Randomness shortcut
var rng = RandomNumberGenerator.new()

#Room arrays
var rightDoorRooms = ["center", "leftEdge", "leftUp", "leftBottom", "leftFork", "leftRight", "bottomFork", "topFork"];
var leftDoorRooms = ["center", "rightEdge", "rightUp", "rightBottom", "rightFork", "leftRight", "bottomFork", "topFork"];
var bottomDoorRooms = ["center", "topEdge", "topFork", "leftUp", "rightUp", "rightFork", "leftFork", "topBottom"];
var topDoorRooms = ["center", "bottomEdge", "bottomFork", "leftBottom", "rightBottom", "rightFork", "leftFork", "topBottom"];

func _ready():
	#Start with the center room. This is always an area_center type.
	numGenerated += 1;
	Global_Var.map["0_0"] = "center";
	queue.append_array(["1_0", "0_-1", "0_1", "-1_0"])
	generateMap();
	print(Global_Var.map);
	
func generateMap():
	#var previousRoom = "0_0_0_0";
	while(numToGenerate > numGenerated):
		var roomToAdd = queue.back();
		if(!Global_Var.map.has(roomToAdd)): #Extra check because some were slipping through.
			addRoom(roomToAdd);
		else:
			queue.erase(roomToAdd);
	
func addRoom(code):
	print("Code: " + code);
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
	while(areaPicked == null || Global_Var.areas[areaPicked].size() <= (numToGenerate-numGenerated-queue.size())):
		areaPicked = roomOptions[rng.randi_range(0, roomOptions.size()-1)]
	#Area has been selected. Add it to the map!
	Global_Var.map[code] = areaPicked;
	#And remove the area from the queue.
	queue.erase(code);
	
	#Add its neighbors to the queue if it has more than one gate.
	if(Global_Var.areas[areaPicked].size() > 1):
		var splitCode = code.rsplit("_");
		#Add area to the left to the queue if it's not already in it OR in the map.
		if(leftDoorRooms.has(areaPicked)):
			var leftArr = splitCode.duplicate();
			leftArr[1] = str(int(leftArr[1]) - 1);
			var leftCode = "_".join(leftArr);
			#If it's not in the map or queue, add it to the queue with code as previous.
			if(!Global_Var.map.has(leftCode) && !queue.has(leftCode)):
				print("Added new code " + leftCode + " to queue");
				queue.append(leftCode);
		#Add area to the right.
		if(rightDoorRooms.has(areaPicked)):
			var rightArr = splitCode.duplicate();
			rightArr[1] = str(int(rightArr[1]) + 1);
			var rightCode = "_".join(rightArr);
			#If it's not in the map or queue, add it to the queue with code as previous.
			if(!Global_Var.map.has(rightCode) && !queue.has(rightCode)):
				print("Added new code " + rightCode + " to queue");
				queue.append(rightCode);
		#Add area to the top.
		if(topDoorRooms.has(areaPicked)):
			var topArr = splitCode.duplicate();
			topArr[0] = str(int(topArr[0]) + 1);
			var topCode = "_".join(topArr);
			#If it's not in the map or queue, add it to the queue with code as previous.
			if(!Global_Var.map.has(topCode) && !queue.has(topCode)):
				print("Added new code " + topCode + " to queue");
				queue.append(topCode);
		#Add area to the bottom.
		if(bottomDoorRooms.has(areaPicked)):
			var bottomArr = splitCode.duplicate();
			bottomArr[0] = str(int(bottomArr[0]) - 1);
			var bottomCode = "_".join(bottomArr);
			#If it's not in the map or queue, add it to the queue with code as previous.
			if(!Global_Var.map.has(bottomCode) && !queue.has(bottomCode)):
				print("Added new code " + bottomCode + " to queue");
				queue.append(bottomCode);
	print("Picked an area: " + areaPicked + " at code " + code);
	
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
	print("neighbor code: " + neighborCode);
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
