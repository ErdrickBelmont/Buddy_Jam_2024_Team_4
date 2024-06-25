extends Node

var wood: int = 0
var woodExportCap: int = 100
var energy: int = 10
var fertilizer: int = 0
var quota: int = 10

func woodAdd(inVal: int):
	wood = wood + inVal
func energyAdd(inVal: int):
	energy = energy + inVal
func fertilizerAdd(inVal: int):
	fertilizer = fertilizer + inVal
func check(lesser:int, max:int) -> bool:
	if (lesser <= max):
		return true
	else:
		return false
