extends KinematicBody2D

var vel = Vector2.ZERO
export var speed = 250
export var gravity = 50
export var jumpForce = -1000
var attacking = false
var is_robot = true

func _physics_process(_delta):
	
	if Input.is_action_just_pressed("switch"):
		$robot.visible = not $robot.visible
		$hero.visible = not $hero.visible
		is_robot = not is_robot

	# horizontal movement
	if Input.is_action_pressed("left"):
		vel.x = -speed
		$robot.scale.x = -0.151
		$hero.scale.x = -0.135
		$Weapon.position = Vector2(-30, 72.028)
		if not attacking: 
			$RobotAnimation.play("Walking")
			$HeroAnimation.play("walking")
	elif Input.is_action_pressed("right"):
		$robot.scale.x = 0.151
		$hero.scale.x = 0.135
		vel.x = speed
		$Weapon.position = Vector2(30, 72.028)
		if not attacking: 
			$RobotAnimation.play("Walking")
			$HeroAnimation.play("walking")
	else: 
		vel.x = 0
		if not attacking: 
			$RobotAnimation.play("idle")
			$HeroAnimation.play("idle")
	
	# gravity
	vel.y += gravity

	# reset the vertical velocity if the player is on the floor
	if is_on_floor() or is_on_ceiling():
		vel.y = 0
		
	# jumping
	if Input.is_action_pressed("up") and is_on_floor():
		vel.y = jumpForce
	
	
	move_and_slide(vel, Vector2.UP)

