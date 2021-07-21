extends StaticBody2D

onready var camera = get_tree().get_root().get_node("Node2D/Player/Camera2D")
onready var levelGenerator = get_tree().get_root().get_node("Node2D/Level Generator")
var trees = [
	preload("res://Level design/trees/tree1.png"),
	preload("res://Level design/trees/tree2.png"),
	preload("res://Level design/trees/tree3.png"),
	preload("res://Level design/trees/tree4.png"),
	preload("res://Level design/trees/tree5.png"),
	preload("res://Level design/trees/tree6.png")
]
var obstacle = preload("res://scene/obstacle.tscn")

func _ready():
	randomize()
	
	var treeNum = rand_range(0, 3)
	var haveObstacle = rand_range(0, 1)
	for i in range(treeNum):
		var tree = trees[rand_range(0, len(trees))]
		var sprite = Sprite.new()
		sprite.position = Vector2(rand_range(0, 10) ,-12.5)
		sprite.texture = tree
		sprite.z_index = -11
		sprite.scale = Vector2.ONE * 0.03
		add_child(sprite)
	if haveObstacle <= 0.5:
		var obs = obstacle.instance()
		obs.position = Vector2(rand_range(-10, 10) ,-12.5)
		obs.scale = Vector2.ONE * 0.2
		obs.connect("body_entered", self, "on_Area2D_body_entered")
		add_child(obs)

func _process(delta):
	if global_position.x < camera.global_position.x - 700:
		levelGenerator.num_of_platforms -= 1
		queue_free()
		
func on_Area2D_body_entered(body):
	if body.name == "Player":
		body.die()
