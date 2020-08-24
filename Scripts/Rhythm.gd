extends Node2D

var speed = 75

var state = 1
var choices = [
	"res://Assets/Arrows/down-arrow.png",
	"res://Assets/Arrows/left-arrow.png",
	"res://Assets/Arrows/up-arrow.png",
	"res://Assets/Arrows/right-arrow.png"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	state = int(rand_range(0, 4))
	
	$Sprite.texture = load(choices[state])
	
func _process(delta):
	position.y += speed * delta
	
	if (position.y > 320):
		
		get_parent().total_missed += 1
		get_parent().get_parent().get_node("boss-head").got_hit(-20)
		queue_free()

func destroy():
	var particles = load("res://Scenes/Arrow-Particles.tscn").instance()
	get_parent().add_child(particles)
	particles.emitting = true
	particles.position = position
	
	get_parent().remove_child(self)
	queue_free()

