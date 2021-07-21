extends KinematicBody2D

var vel = Vector2.ZERO
export var speed = 250
export var gravity = 50
export var jumpForce = -1000
var attacking = false
var is_robot = false
var is_dead = false

func _physics_process(_delta):
	
	if is_dead: return
	
	if position.y > 1000: die()
	
	get_parent().get_node("CanvasLayer").score = int(position.x/300)
	
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
	if Input.is_action_pressed("up") and is_on_floor() and not is_robot:
		vel.y = jumpForce
	
	
	move_and_slide(vel, Vector2.UP)
	
func die():
	var lives = get_parent().get_node("CanvasLayer/Lives").get_child_count()
	if lives <= 0:
		is_dead = true
		$hero.queue_free()
		$robot.queue_free()
		$TextureRect/Label.text = "score: " + str(get_parent().get_node("CanvasLayer").score)
		$Tween.interpolate_property($TextureRect, "rect_position", $TextureRect.rect_position, Vector2($TextureRect.rect_position.x, -305.58), 1, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
		$Tween.start()
	else:
		modulate = Color.red
		get_parent().get_node("CanvasLayer/Lives").get_child(lives-1).queue_free()
		yield(get_tree().create_timer(0.1), "timeout")
		modulate = Color.white

func _on_TextureButton_pressed():
	get_tree().change_scene("res://scene/main scene.tscn")

func _on_TextureButton2_pressed():
	get_tree().change_scene("res://scene/Main Menu.tscn")
