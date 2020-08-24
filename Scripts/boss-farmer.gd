extends Sprite

var dialogue = preload("res://Scenes/Dialogue.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var d = dialogue.instance()
	add_child(d)
	
	d.messages = ["Debug", "Hello"]
	d.messages = [
		"Stop, and listen.", 
		"We form the first seal.",
		"We are the protectors of the library tomb.", 
		".....",
		"The heads and their trials were established to keep others from entering...",
		"To keep others from the risk of releasing you.",
		"You who would be the death of our world.",
		".....",
		"You have won, and now you have a choice.",
		"I will open a portal.",
		"It will strip you off your power",
		"It will take from you your memory",
		"Take your exile as your own choice...",
		"So that someday we may exist together in peace."
		]
	d.start_dialogue()

func done_speaking():
	get_parent().get_node("Portal").visible = true
	get_parent().get_node("Player").frozen = false
	
func got_hit(damage):
	pass

