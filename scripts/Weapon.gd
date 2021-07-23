extends Area2D

var enemies_in_range = null
var timeBtwShot = 0
var startTimeBtwShot = 1

func _process(delta):
	if Input.is_action_just_pressed("attack") and get_parent().is_robot and timeBtwShot <= 0:
		$AudioStreamPlayer.play()
		get_parent().attacking = true
		if enemies_in_range:
			enemies_in_range.hurt()
		timeBtwShot = startTimeBtwShot
		get_parent().get_node("RobotAnimation").play("attack")
		yield(get_parent().get_node("RobotAnimation"), "animation_finished")
		get_parent().attacking = false
	else:
		timeBtwShot -= delta

func _on_Weapon_body_entered(body):
	if "Enemy" in body.name:
		enemies_in_range = body

func _on_Weapon_body_exited(body):
	if body == enemies_in_range:
		enemies_in_range = null
