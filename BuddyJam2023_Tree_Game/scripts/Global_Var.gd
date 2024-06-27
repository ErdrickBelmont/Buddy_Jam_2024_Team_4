extends Node

var wood = 0
var energy = 10
var fertilizer = 0
var quota = 10

var map = {}; #Dictionary containing all the current areas on the map. Format X_Y from the center area 0_0. Like XY coordinates.
#Dictionary of areas, with key = area name & value = array with types of gates.
var areas = {"center": ["left", "right", "top", "bottom"],
			"bottomEdge": ["top"],
			"topEdge": ["bottom"],
			"leftEdge": ["right"],
			"rightEdge": ["left"],
			"leftBottom": ["top", "right"],
			"rightBottom": ["top", "left"],
			"leftUp": ["bottom", "right"],
			"rightUp": ["bottom", "left"],
			"topBottom": ["top", "bottom"],
			"leftRight": ["left", "right"],
			"bottomFork": ["left", "top", "right"],
			"topFork": ["left", "bottom", "right"],
			"leftFork": ["top", "right", "bottom"],
			"rightFork": ["left", "top", "bottom"] }
var position = "0_0"; #lol, face
var day = 1;
var stormCounter = 0;
#var moveScript = preload("res://scripts/movePlayer.gd").new();
