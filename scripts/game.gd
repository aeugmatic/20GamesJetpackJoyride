extends Node

# "run speed" of the player - dictates how fast the level moves horizontally,
# relative to the player 
var run_speed: float = 100.0 

var zapper: PackedScene = preload("res://scenes/obstacles/Zapper.tscn")

func _ready() -> void:
	generate_obstacle()

func _physics_process(delta: float) -> void:
	pass

func generate_obstacle() -> void:
	var zapper_scene: Node2D = zapper.instantiate()
	$Obstacles.add_child(zapper_scene)
