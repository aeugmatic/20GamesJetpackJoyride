extends Area2D

const PROBE_MIN_DIST: float = 75.0 # min distance probe can be from origin
const PROBE_MAX_DIST: float = 120.0 # max distance probe can be from origin
const ANG_SPEED: float = 0.025

var rotating: bool = false

func _ready() -> void:
	# Create the zapper
	place_probes()
	generate_line()
	generate_coll_shape()

func _process(delta: float) -> void:
	if rotating:
		rotation += ANG_SPEED

func place_probes() -> void:
	# Get distance and direction (using polar coords)
	var distance: float = randf_range(PROBE_MIN_DIST, PROBE_MAX_DIST)
	var direction: Vector2 = Vector2(
		randf_range(-1.0, 1.0),
		randf_range(-1.0, 1.0)
	).normalized()
	
	# Set distances of the probes
	$ProbeSprite1.position = position + (distance * direction)
	$ProbeSprite2.position = position + (distance * -direction)
	
	# Make probes point in direction of laser
	$ProbeSprite1.look_at($ProbeSprite2.position)
	$ProbeSprite2.look_at($ProbeSprite1.position)
	
func generate_line() -> void:
	$ZapLine.add_point($ProbeSprite1.position, 0)
	$ZapLine.add_point($ProbeSprite2.position, 1)
	
func generate_coll_shape() -> void:
	var probe_dist: float = $ProbeSprite1.position.distance_to($ProbeSprite2.position)
	var probe_radius: float = 15.0
	
	# Create shape and position it
	$CollisionShape2D.shape = CapsuleShape2D.new()
	$CollisionShape2D.shape.radius = 10.0
	$CollisionShape2D.shape.height = probe_dist + 2*probe_radius
	$CollisionShape2D.position = 0.5 * ($ProbeSprite1.position + $ProbeSprite2.position)
	
	# Rotate shape to fit zapper
	$CollisionShape2D.look_at($ProbeSprite1.position) # shape is perpendicular to laser line...
	$CollisionShape2D.rotate(PI / 2.0) # ...so rotate the shape by 90deg to correct that

func toggle_rotating() -> void:
	rotating = not rotating
