extends Sprite

var dir = Vector2.ZERO

var SPEED = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
	new_direction()
	
	var state = int(rand_range(1, 5))
	texture = load("res://Assets/Potions/potion-" + str(state) + ".png")

func new_direction():
	randomize()
	
	dir.x = rand_range(-5, 5)
	dir.y = rand_range(-5, 5)
	
	dir = dir.normalized()

func _process(delta):
	var target = position + (SPEED * dir * delta * 2)
#	while (target.x < 192 or target.x > 288 or target.y < 0 or target.y > 320):
	var amount = 0
	for i in range(0, 20):
		if (target.x < 100 or target.x > 380 or target.y < 0 or target.y > 320):
			new_direction()
		target = position + dir 
	if (target.x < 100 or target.x > 380 or target.y < 0 or target.y > 320):
		queue_free()
	position += (SPEED * dir * delta)
