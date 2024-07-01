extends Control
@onready var sell = $sell
@onready var basetheme = $basetheme
# Called when the node enters the scene tree for the first time.
func _ready():
	basetheme.play()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_next_day_pressed():
	
	Global_Var.storm_reset()
	get_tree().change_scene_to_file("res://scenes/forest_entrance.tscn")
	basetheme.stop()

func _on_submit_wood_quota_pressed():
	var quota_difference : int = (Global_Var.get_referance("quota") - Global_Var.get_referance("qoutaTracker"))
	
	if Global_Var.upperBoundCheck(Global_Var.get_referance("qoutaTracker"),Global_Var.get_referance("quota")):
		sell.play()
		if Global_Var.get_referance("wood") + Global_Var.get_referance("qoutaTracker") < Global_Var.get_referance("quota"):
			Global_Var.add_to_var("quotaTracker", Global_Var.get_referance("wood"))
			Global_Var.set_var("wood",0)
		elif Global_Var.get_referance("wood") + Global_Var.get_referance("qoutaTracker") >= Global_Var.get_referance("quota"):
			Global_Var.add_to_var("wood", -quota_difference)
			Global_Var.set_var("quotaTracker", Global_Var.get_referance("quota"))
			Global_Var.quota_fufilled = true

func _on_build_fortitifcation_pressed():
	var fortification_difference : int = Global_Var.get_referance("fortificationCost") - Global_Var.get_referance("fortificationTracker")
	
	if Global_Var.upperBoundCheck(Global_Var.get_referance("fortificationTracker"),Global_Var.get_referance("fortificationCost")):
		sell.play()
		if Global_Var.get_referance("wood") + Global_Var.get_referance("fortificationTracker") < Global_Var.get_referance("fortificationCost"):
			Global_Var.add_to_var("fortificationTracker", Global_Var.get_referance("wood"))
			Global_Var.set_var("wood",0)
		elif Global_Var.get_referance("wood") + Global_Var.get_referance("fortificationTracker")  >= Global_Var.get_referance("fortificationCost"):
			Global_Var.add_to_var("wood", -fortification_difference)
			Global_Var.set_var("fortificationTracker", Global_Var.get_referance("fortificationCost"))
			Global_Var.base_fortified = true
