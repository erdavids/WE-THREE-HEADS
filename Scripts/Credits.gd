extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if (Input.is_action_just_pressed("ui_cancel")):
		get_tree().change_scene("res://Scenes/Menu.tscn")


func _on_TheBuffED_pressed():
	OS.shell_open("https://www.youtube.com/channel/UCUrmX3SvpPerq-KAfGBrgGQ")

func _on_Kenney_pressed():
	OS.shell_open("https://www.kenney.nl/")


func _on_Miziziziz_pressed():
	OS.shell_open("https://www.youtube.com/channel/UCaoqVlqPTH78_xjTjTOMcmQ")
