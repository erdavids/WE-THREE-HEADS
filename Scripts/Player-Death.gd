extends Node2D

var particles = load("res://Scenes/Boss-Particles.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.frozen = true
	$Player.position = Global.character_death_position
	
	$Timer.set_wait_time(6)
	$Timer.one_shot = true
	$Timer.start()
	
	$Timer2.set_wait_time(10)
	$Timer2.start()
	
	$Air.playing = true

func _on_Timer_timeout():
	var p = particles.instance()
	get_parent().add_child(p)
	p.emitting = true
	p.position = Global.character_death_position
	print(p.position)
	
	get_node("Player").queue_free()
	

func _on_Timer2_timeout():
	if (Global.game_completed == false):
		get_tree().change_scene("res://Scenes/Menu.tscn")
	else:
		get_tree().change_scene("res://Scenes/Ending.tscn")
