extends StaticBody2D

var state = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	reroll()

func reroll():
	randomize()
	var old_state = state
	while(old_state == state):
		state = int(rand_range(1, 7))
	$Sprite.texture = load("res://Assets/DICE/dice-" + str(state) + ".png")
	
	# ADD SOUND (roll sound)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
