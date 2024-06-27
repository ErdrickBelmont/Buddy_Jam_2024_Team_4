extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_next_day_pressed():
	Global_Var.storm_reset()
	get_tree().change_scene_to_file("res://forest_entrance.tscn")


func _on_submit_wood_quota_pressed():
	if Global_Var.upperBoundCheck(Global_Var.get_referance("qoutaTracker"),Global_Var.get_referance("quota")):
		if (Global_Var.get_referance("wood") - (Global_Var.get_referance("quota") - Global_Var.get_referance("qoutaTracker"))) >= 0:
			Global_Var.add_to_var("quotaTracker",(Global_Var.get_referance("quota") - Global_Var.get_referance("qoutaTracker")))
			Global_Var.add_to_var("wood",-((Global_Var.get_referance("quota") - Global_Var.get_referance("qoutaTracker"))))

func _on_build_fortitifcation_pressed():
	var fortification_difference = Global_Var.get_referance("fortificationCost") - Global_Var.get_referance("fortificationTracker")
	if Global_Var.upperBoundCheck(Global_Var.get_referance("fortificationTracker"),Global_Var.get_referance("fortificationCost")):
		if (Global_Var.get_referance("wood") - (Global_Var.get_referance("fortificationCost") - Global_Var.get_referance("fortificationTracker"))) >= 0:
			Global_Var.add_to_var("fortificationTracker",(Global_Var.get_referance("fortificationCost") - Global_Var.get_referance("fortificationTracker")))
			Global_Var.add_to_var("wood",-(Global_Var.get_referance("fortificationCost") - Global_Var.get_referance("fortificationTracker")))


