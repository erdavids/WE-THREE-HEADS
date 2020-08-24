extends Node2D

var current_level = 0

var lives = 1
var difficulty = "impossible"

var game_completed = false
var game_ending = "PEACE"

var character_death_position = Vector2.ZERO

func _ready():
	pass
	
func stop_all_music():
	for m in get_children():
		m.playing = false

func _process(delta):
	var c = get_tree().current_scene.get_name()
	if (c == "Menu" and $"Intro-Music".playing == false):
		stop_all_music()
		$"Intro-Music".playing = true
	elif (c == "Boss-1" and $"boss-1-music".playing == false):
		stop_all_music()
		$"boss-1-music".playing = true
	elif (c == "Boss-2" and $"boss-2-music".playing == false):
		stop_all_music()
		$"boss-2-music".playing = true
	elif (c == "Boss-3" and $"boss-3-music".playing == false):
		stop_all_music()
		$"boss-3-music".playing = true
	elif (c == "Boss-4" and $"outro-music".playing == false):
		stop_all_music()
		$"outro-music".playing = true
