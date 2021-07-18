extends Node2D

var num_of_platforms = 100
var spawn_pos = Vector2.ZERO
var platform = preload("res://Platform.tscn")

func _ready():
	randomize()
	for i in range(num_of_platforms):
		spawnRandom()
		
func spawnRandom():
	var p = platform.instance()
	p.scale.x = rand_range(1, 5)
	p.position = spawn_pos
	add_child(p)
	spawn_pos += Vector2(200, rand_range(-100, 100))
