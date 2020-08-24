extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Inner.rotate(6 * delta)
	$Outer.rotate(-3 * delta)
	
#	if (rand_range(0, 1) < .1):
#		visible = false
#	else:
#		visible = true
#
