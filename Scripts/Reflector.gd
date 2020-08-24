extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.set_wait_time(.2)
	$Timer.start()

func _process(delta):
	rotate(20 * delta)
	scale.x += .02 
	scale.y += .02


func _on_Timer_timeout():
	get_parent().remove_child(self)
	queue_free()
