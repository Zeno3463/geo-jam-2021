extends Area2D

var enemies_in_range = null

func _process(delta):
	if Input.is_action_just_pressed("attack"):
		get_parent().attacking = true
		if enemies_in_range:
			enemies_in_range.queue_free()
			enemies_in_range = null
		get_parent().get_node("AnimationPlayer").play("attack")
		yield(get_parent().get_node("AnimationPlayer"), "animation_finished")
		get_parent().attacking = false

func _on_Weapon_body_entered(body):
	if "Enemy" in body.name:
		enemies_in_range = body

func _on_Weapon_body_exited(body):
	if body == enemies_in_range:
		enemies_in_range = null
