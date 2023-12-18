extends Node2D


# Called when the node enters the scene tree for the first time.
var rng = RandomNumberGenerator.new()
var random_speed
func _ready():
	random_speed = rng.randf_range(50.0,100.0)

var t = 0.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	t+= delta
	$Path2D/PathFollow2D.progress = t  * random_speed
	
