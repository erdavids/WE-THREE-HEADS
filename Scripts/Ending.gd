extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if (Global.game_ending == "PEACE"):
		$Label.text = "For the first time in thousands of years, there was hope greater than fear. After an additional ten years of exile, the farmer and his wife visited the library tomb and met with the outcast. They believed that he had been reborn through the portal's magic as well as his seclusion. They welcomed him back to their home and he became a willing member of their family.\n\nThey could not have known that he remembered everything, and retained all his power. In this way, he had truly transformed into something hopeful as he chose against his nature to find peace for himself and others."
	else:
		$Label.text = "The beast was placed violently back in exile deep within the caverns beneath the farmland. It took time to rebuild the seals, but they were created stronger than before, and in greater numbers.\n\nThousands of years passed, and the creature was only remembered in the corners of the darkest imaginations.\n\nDeep within the earth, he was making his way through the seals."

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TextureButton_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")
