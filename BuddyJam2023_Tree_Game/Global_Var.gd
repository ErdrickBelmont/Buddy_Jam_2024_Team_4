extends Node


var dic : Dictionary = {"wood": 0,"woodExportTracker": 0, "woodExportCap": 100,"fortificationTracker": 0,"fortificationCost": 10, "energy": 0, "maxEnergy": 10, "fertilizer": 0,"quotaTracker":0, "quota": 100 }

var base_fortified: bool = false
var quota_fufilled: bool = false

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
		print("upBound:true")
		return true
	else:
		print("upBound:false")
		return false
func lowerBoundCheck(currentInt:int, minimumRequired:int) -> bool:
	if (currentInt < minimumRequired):
		return false
	else:
		return true

func storm_reset():
	set_var("energy",dic.maxEnergy)
	set_var("woodExportTracker",0)
	#set_var("quotaTracker",0)
	base_fortified = false


