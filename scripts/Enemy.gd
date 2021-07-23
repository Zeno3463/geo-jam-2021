extends KinematicBody2D

var vel = Vector2(1, 0)
var speed = 20
export var gravity = 50

onready var camera = get_tree().get_root().get_node("Node2D/Player/Camera2D")
onready var levelGenerator = get_tree().get_root().get_node("Node2D/Level Generator")

export var health = 1

func _process(delta):
	if global_position.x < camera.global_position.x - 700:
		levelGenerator.num_of_platforms -= 1
		queue_free()
	if health <= 0:
		health = 1
		$AudioStreamPlayer.play()
		for child in get_children():
			if child != $AudioStreamPlayer:
				child.queue_free()
		yield($AudioStreamPlayer, "finished")
		queue_free()

func _physics_process(delta):
	vel.y += gravity
	if is_on_floor() or is_on_ceiling():
		vel.y = 0
	move_and_slide(Vector2(vel.x * speed, vel.y) , Vector2.UP)

func hurt():
	$AudioStreamPlayer.play()
	$Head.modulate = Color.red
	yield(get_tree().create_timer(0.1), "timeout")
	$Head.modulate = Color.white
	health -= 1

func _on_Area2D_body_exited(body):
	scale.x *= -1
	vel.x *= -1

func _on_Area2D2_body_entered(body):
	if body.name == "Player":
		body.die()
