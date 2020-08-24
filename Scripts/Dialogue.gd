extends Node2D


var current_message = 0
var message_complete = false

var messages = []

var display = ""
var current_char = 0

var listen = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func start_dialogue():
	current_message = 0
	display = ""
	current_char = 0
	current_message = 0
	message_complete = false
	
	$Timer.set_wait_time(.06)
	$Timer.start()
	
	listen = true

func stop_dialogue():
	display = ""
	current_char = 0
	current_message = 0
	$Label.text = ""
	messages = []
	$Timer.stop()
	
	
	get_parent().done_speaking()
	get_parent().remove_child(self)
	
	
func _process(delta):
	if (Input.is_action_just_pressed("ui_accept") and listen):
		if (message_complete == true):
			if (current_message == len(messages) - 1):
				stop_dialogue()
			else: 
				message_complete = false
				current_message += 1
				display = ""
				current_char = 0
				$Timer.paused = false
		else:
			message_complete = true
			$Label.text = messages[current_message]
			$Timer.paused = true

			$next_message.one_shot = true
			$next_message.set_wait_time(2)
			$next_message.start()

func timeout():
	if (current_char < len(messages[current_message])):
		display += messages[current_message][current_char]
		$Label.text = display
		$Timer.paused = false
		current_char += 1
	else:
		message_complete = true
		$Timer.paused = true
		$next_message.one_shot = true
		$next_message.set_wait_time(2)
		$next_message.start()


func _on_next_message_timeout():
	if (current_message == len(messages) - 1):
		stop_dialogue()
	else: 
		message_complete = false
		current_message += 1
		display = ""
		current_char = 0
		$Timer.paused = false
