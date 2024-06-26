extends Label



var matchName: String
var relevantGlobalInt: String


func _init():
	matchName = String(self.get_name())
	
func _ready():
	matchName = String(self.get_name())
	match matchName:
		"WoodInt":
			relevantGlobalInt = "wood"
			self.text = str(Global_Var.get_referance("wood"))
		"WoodCapInt":
			relevantGlobalInt = "woodExportCap"
			self.text = str(Global_Var.get_referance("woodExportCap"))
		"EnergyInt": 
			relevantGlobalInt = "energy"
			self.text = str(Global_Var.get_referance("energy"))
		"EnergyCapInt":
			relevantGlobalInt = "maxEnergy"
			self.text = str(Global_Var.get_referance("maxEnergy"))
		"FertilizerInt":
			relevantGlobalInt = "fertilizer"
			self.text = str(Global_Var.get_referance("fertilizer"))
		"QuotaInt":
			relevantGlobalInt = "quota"
			self.text = str(Global_Var.get_referance("quota"))
		_:
			print("error: name of node attached not recognized")



func _process(delta):
	#print(matchName)
	if(int(self.text) != Global_Var.get_referance(relevantGlobalInt)):
		self.text = str(Global_Var.get_referance(relevantGlobalInt))