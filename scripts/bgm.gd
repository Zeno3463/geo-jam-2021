extends AudioStreamPlayer

var m1 = preload("res://musics/Background1.ogg")
var m2 = preload("res://musics/Background2.ogg")
var m3 = preload("res://musics/Background3.ogg")
onready var musics = [m1, m2, m3]

func _ready():
	randomize()
	playSound()

func playSound():
	stream = musics[int(rand_range(-1, 3))]
	play()
	yield(self, "finished")
	playSound()
	
