extends CanvasLayer

var score = 0

func _process(delta):
	$Label.text = str(score)
