extends KinematicBody2D

var vel = Vector2.ZERO
export var speed = 250
export var gravity = 50
export var jumpForce = -1000

func _physics_process(_delta):

	# horizontal movement
	if Input.is_action_pressed("left"):
		vel.x = -speed
	elif Input.is_action_pressed("right"):
		vel.x = speed
	else: vel.x = 0
	
	# gravity
	vel.y += gravity

	# reset the vertical velocity if the player is on the floor
	if is_on_floor() or is_on_ceiling():
		vel.y = 0
		
	# jumping
	if Input.is_action_pressed("up") and is_on_floor():
		vel.y = jumpForce
	
	
	move_and_slide(vel, Vector2.UP)

