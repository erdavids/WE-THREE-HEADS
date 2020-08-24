extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.set_wait_time(2)
	$Timer.start()
	

func _on_Timer_timeout():
	var projectile = load("res://Scenes/practice-projectile.tscn").instance()
	projectile.dir = Vector2.DOWN
	projectile.position.y += 10
	projectile.rotation = projectile.dir.angle()
	add_child(projectile)
