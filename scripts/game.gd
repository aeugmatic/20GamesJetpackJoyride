extends Node

var zapper_scene: PackedScene = preload("res://scenes/obstacles/Zapper.tscn")

# "run speed" of the player - dictates how fast the level moves horizontally,
# relative to the player 
var run_speed: float = 300.0 
var vw_size: Vector2 = Vector2.ZERO

func _ready() -> void:
	vw_size = get_viewport().get_visible_rect().size
	generate_obstacle()

func _physics_process(delta: float) -> void:
	for obs in $Obstacles.get_children():
		obs.position.x -= run_speed * delta;

func generate_obstacle() -> void:
	var zapper: Node2D = zapper_scene.instantiate()
	$Obstacles.add_child(zapper)
	
	# NOTE: have to set position AFTER adding it as a child - otherwise it glitches out
	zapper.position = Vector2(
		vw_size.x + 100, # offscreen
		0.5 * vw_size.y
	)
