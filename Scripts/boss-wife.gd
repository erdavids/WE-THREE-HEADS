extends Sprite

var dialogue = preload("res://Scenes/Dialogue.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func final_word():
	
	var sword_circle = load("res://Scenes/Sword-Circle.tscn").instance()
	get_parent().get_node("Player").add_child(sword_circle)
	get_parent().get_node("Player").frozen = true

	var d = dialogue.instance()
	add_child(d)
	
	d.messages = ["You attempt to bring violence here?", 
		"All those years, and nothing learned.",
		"We gave you a chance for peace",
		"And now you will be buried deeper than before."]
	d.start_dialogue()

func done_speaking():
	Global.game_completed = true
	Global.game_ending = "SEALED"
	Global.character_death_position = get_parent().get_node("Player").position
	get_tree().change_scene("res://Scenes/Player-Death.tscn")
	
func got_hit(damage):
	pass

