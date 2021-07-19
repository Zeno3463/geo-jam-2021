extends KinematicBody2D

var vel = Vector2.ZERO
export var speed = 250
export var gravity = 50
export var jumpForce = -1000
var attacking = false

func _physics_process(_delta):

	# horizontal movement
	if Input.is_action_pressed("left"):
		vel.x = -speed
		$body.scale.x = -0.151
		$Weapon.position = Vector2(-30, 72.028)
		if not attacking: $AnimationPlayer.play("Walking")
	elif Input.is_action_pressed("right"):
		$body.scale.x = 0.151
		vel.x = speed
		$Weapon.position = Vector2(30, 72.028)
		if not attacking: $AnimationPlayer.play("Walking")
	else: 
		vel.x = 0
		if not attacking: $AnimationPlayer.play("idle")
	
	# gravity
	vel.y += gravity

	# reset the vertical velocity if the player is on the floor
	if is_on_floor() or is_on_ceiling():
		vel.y = 0
		
	# jumping
	if Input.is_action_pressed("up") and is_on_floor():
		vel.y = jumpForce
	
	
	move_and_slide(vel, Vector2.UP)

