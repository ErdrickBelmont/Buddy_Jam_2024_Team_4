extends Control

func _ready():
	hide() 

func resume():
	get_tree().paused = false
	hide()
func pause():
	get_tree().paused = true
	show()
	
func testEsc():
	if Input.is_action_just_pressed("ui_cancel") and get_tree().paused == false:
		pause()
	elif Input.is_action_just_pressed("ui_cancel") and get_tree().paused == true:
		resume()

func _on_resume_pressed():
	resume()

func _on_options_pressed():
	resume()
	get_tree().reload_current_scene()

func _on_quit_pressed():
	get_tree().quit()
	
func _process(delta):
	testEsc()
