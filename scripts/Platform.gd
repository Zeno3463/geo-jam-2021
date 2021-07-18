extends StaticBody2D

onready var camera = get_tree().get_root().get_node("Node2D/Player/Camera2D")
onready var levelGenerator = get_tree().get_root().get_node("Node2D/Level Generator")

func _process(delta):
	if global_position.x < camera.global_position.x - 700:
		levelGenerator.num_of_platforms -= 1
		queue_free()
