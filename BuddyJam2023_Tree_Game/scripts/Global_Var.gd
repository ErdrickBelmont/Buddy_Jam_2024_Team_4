extends Node

#var wood = 0
#var energy = 10
#var fertilizer = 0
#var quota = 10

var map = {} #Dictionary containing all the current areas on the map. Format X_Y from the center area 0_0. Like XY coordinates.
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

#These two are necessary because of some really weird errors.
var newMapNeeded = true #When true, map can be generated
var moveCooldown = true #When true, player can move to another area

#And these are more "tracking player's current position".
var position = "0_0" #lol, face
var day = 1
var stormCounter = 3

#Dictionaries for storing current trees & bugs on the map, and just one variable for the ship
var treeDict = {};
var bugDict = {};
var ship;

#David's variables
var dic : Dictionary = {"wood": 0,"woodExportTracker": 0, "woodExportCap": 100,"fortificationTracker": 0,"fortificationCost": 10, "energy": 0, "maxEnergy": 10, "fertilizer": 0,"quotaTracker":0, "quota": 100 }

var base_fortified: bool = false

func _ready():
	set_var("energy",dic.maxEnergy)

func get_referance(in_val: String) -> int:
	match in_val:
		"wood":
			return dic.wood
		"woodExportTracker":
			return dic.woodExportTracker
		"woodExportCap":
			return dic.woodExportCap
		"energy": 
			return dic.energy
		"maxEnergy":
			return dic.maxEnergy
		"fertilizer":
			return dic.fertilizer
		"quotaTracker":
			return dic.quotaTracker
		"quota":
			return dic.quota
		"fortificationTracker":
			return dic.fortificationTracker
		"fortificationCost":
			return dic.fortificationCost
		_:
			return 0
		
func set_var(key:String, new_value: int):
	match key:
		"wood":
			dic.wood = new_value
		"woodExportTracker":
			dic.woodExportTracker = new_value
		"woodExportCap":
			dic.woodExportCap = new_value
		"energy": 
			dic.energy = new_value
		"maxEnergy":
			dic.maxEnergy = new_value
		"fertilizer":
			dic.fertilizer = new_value
		"quotaTracker":
			dic.quotaTracker = new_value
		"quota":
			dic.quota = new_value
		"fortificationTracker":
			dic.fortificationTracker = new_value
		"fortificationCost":
			dic.fortificationCost = new_value
		_:
			print("could not find variable")
			
func add_to_var(key:String, new_value: int):
	match key:
		"wood":
			dic.wood += new_value
		"woodExportTracker":
			dic.woodExportTracker += new_value
		"woodExportCap":
			dic.woodExportCap += new_value
		"energy": 
			dic.energy += new_value
		"maxEnergy":
			dic.maxEnergy += new_value
		"fertilizer":
			dic.fertilizer += new_value
		"quotaTracker":
			dic.quotaTracker += new_value
		"quota":
			dic.quota += new_value
		"fortificationTracker":
			dic.fortificationTracker += new_value
		"fortificationCost":
			dic.fortificationCost += new_value
		_:
			print("could not find variable")
	

func upperBoundCheck(lesser:int, max:int) -> bool:
	if (lesser < max):
		return true
	else:
		return false
func lowerBoundCheck(currentInt:int, minimumRequired:int) -> bool:
	if (currentInt < minimumRequired):
		return false
	else:
		return true

func storm_reset():
	set_var("energy",dic.maxEnergy)
	set_var("woodExportTracker",0)
	set_var("quotaTracker",0)
	newMapNeeded = true
	treeDict = {};
	bugDict = {};

