extends Node2D

var num_of_platforms = 0
var spawn_pos = Vector2.ZERO
var platform = preload("res://scene/Platform.tscn")
var enemies = [preload("res://scene/Enemy.tscn"), preload("res://scene/Enemy2.tscn")]

func _ready():
	randomize()

func _process(delta):
	if num_of_platforms < 10:
		spawnRandom()
		num_of_platforms += 1
		
func spawnRandom():
	var p = platform.instance()
	p.scale.x = rand_range(5, 10)
	p.scale.y = p.scale.x
	p.position = spawn_pos
	add_child(p)
	
	if rand_range(0, 1) <= 0.2:
		var e = enemies[int(rand_range(0, 2))].instance()
		e.position = spawn_pos + Vector2(0, -50)
		add_child(e)
	
	spawn_pos += Vector2(300, rand_range(-100, 100))
