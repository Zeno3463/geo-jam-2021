extends Node2D

func _on_TextureButton_pressed():
	get_tree().change_scene("res://scene/main scene.tscn")

func _on_TextureButton_mouse_entered():
	$CanvasLayer/TextureButton.modulate = Color8(115, 115, 115, 255)

func _on_TextureButton_mouse_exited():
	$CanvasLayer/TextureButton.modulate = Color.white

func _on_TextureButton2_pressed():
	$CanvasLayer/AnimationPlayer.play("slide")

func _on_Button_pressed():
	$CanvasLayer/AnimationPlayer.play_backwards("slide")
