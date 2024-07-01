extends CharacterBody2D


@export var SPEED = 500.0
@onready var grassfootstep = $grassfootstep
@onready var animPlayer = $Area2D2/AnimationPlayer
@onready var animTree = $Area2D2/AnimationTree
#const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var swinging = false

func _ready():
	SignalBus.connect("player_swing", _on_player_swing)

func _physics_process(delta):
	# Add the gravity.
	#if not is_on_floor():
	#	velocity.y += gravity * delta

	# Handle jump
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	set_velocity(Vector2(0,0))
	var vertical_direction = Input.get_axis("ui_up","ui_down")
	var horizontal_direction = Input.get_axis("ui_left", "ui_right")
	#diagonal in all directions
	if vertical_direction && horizontal_direction:
		velocity.x = horizontal_direction * SPEED
		velocity.y = vertical_direction * SPEED
		
	# Horizontal left and right direction
	elif horizontal_direction:
		velocity.x = horizontal_direction * SPEED
	elif vertical_direction:
		velocity.y = vertical_direction * SPEED
	else:
		set_velocity(Vector2(0,0))
	#if vertical_direction || horizontal_direction:
		#grassfootstep.play()

	if velocity == Vector2.ZERO and not swinging:
		animTree.get("parameters/playback").travel("Idle")
	elif velocity != Vector2.ZERO and not swinging:
		animTree.set("parameters/Idle/blend_position", velocity.normalized())
		animTree.set("parameters/Walk/blend_position", velocity.normalized())
		animTree.set("parameters/Swing/blend_position", velocity.normalized())
		animTree.get("parameters/playback").travel("Walk")
		move_and_slide()

func _on_player_swing():
	print(animTree.get("parameters/Swing/blend_position"))
	animTree.get("parameters/playback").travel("Swing")
	swinging = true

func _on_animation_tree_animation_finished(anim_name):
	if anim_name.contains("swing"):
		swinging = false
	else:
		print(anim_name)

func _on_swing_finished():
	swinging = false
	
