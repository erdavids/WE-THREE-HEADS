extends Node2D

var rhythm = preload("res://Scenes/Rhythm.tscn")

var start_time
var speed

var phase_two = false

var total_missed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _process(delta):
	if (total_missed > get_parent().get_node("boss-head").misses_allowed):
		Global.character_death_position = get_parent().get_node("Player").position
		get_tree().change_scene("res://Scenes/Player-Death.tscn")
	
func start():
	randomize()
	if (Global.difficulty == "impossible"):
		$Timer.set_wait_time(.7)
		start_time = .7
		speed = 70
	else:
		$Timer.set_wait_time(.9)
		start_time = .9
		speed = 50
	$Timer.start()

func next_phase():
	phase_two = true
	randomize()
	$Timer.set_wait_time(start_time / 2)
	$Timer.start()
	
	
func stop():
	$Timer.stop()



func _on_Timer_timeout():
	# Spawn rhythm
	var r = rhythm.instance()
	if (phase_two):
		r.speed = speed * 1.8
	else:
		r.speed = speed
	
	if (rand_range(0, 1) < .5):
		r.position = $"left-emit".position
	else:
		r.position = $"right-emit".position
	
	add_child(r)
	
