extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.current_level = 0
	Global.game_completed = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_HowTo_pressed():
	Global.lives = 1000
	get_tree().change_scene("res://Scenes/HowTo.tscn")

func _on_NormalMode_pressed():
	Global.lives = 5
	Global.difficulty = "normal"
	get_tree().change_scene("res://Scenes/World.tscn")

func _on_Impossible_pressed():
	Global.lives = 1
	Global.difficulty = "impossible"
	get_tree().change_scene("res://Scenes/World.tscn")


func _on_Credits_pressed():
	get_tree().change_scene("res://Scenes/Credits.tscn")
