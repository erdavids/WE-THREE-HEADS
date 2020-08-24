extends Sprite

var dialogue = preload("res://Scenes/Dialogue.tscn")

var particles = preload("res://Scenes/Boss-Particles.tscn")

var starting_health = 350
var health = 350

var first_phase = true

var vulnerable = true

var misses_allowed

func _ready():
	if (Global.difficulty == "impossible"):
		misses_allowed = 5
	else:
		misses_allowed = 25
	
	var d = dialogue.instance()
	add_child(d)
	d.messages = ["I am the seal of Dexterity.", "If you misstep, I will heal.", "Don't miss more than " + str(misses_allowed) + ".", "Begin."]
	d.start_dialogue()
	
	
	
func got_hit(damage):
	if (vulnerable):
		health -= damage
		get_parent().get_node("boss-health").value = health
		
		if (health <= starting_health/2 and first_phase):
			$StartTimer.set_wait_time(5)
			$StartTimer.one_shot = true
			$StartTimer.start()
	
			var d = dialogue.instance()
			add_child(d)
			d.messages = ["Time for the real test"]
			d.start_dialogue()
			
			for c in get_parent().get_node("emitter").get_children():
				if ("Rhythm" in c.name):
					c.destroy()
			
			get_parent().get_node("emitter").stop()
			
			first_phase = false
			pass
		
		
		if (health <= 0):
			var p = particles.instance()
			get_parent().add_child(p)
			p.emitting = true
			p.position = position
			
			get_parent().get_node("emitter").queue_free()
			get_parent().get_node("boss-health").queue_free()
			
			var portal = load("res://Scenes/Portal.tscn").instance()
			get_parent().add_child(portal)
			portal.position = position
			
			get_parent().get_node("walls-one").queue_free()

			var bookstacks = load("res://Scenes/Bookstacks.tscn").instance()
			get_parent().add_child(bookstacks)
			bookstacks.position = position + Vector2(0, -35)
			bookstacks.get_node("book-info").text = "You have succeeded in releasing the first seal and have proven your skill exists beyond the average.\n\nThe creature you are hunting lies beyond the two remaining trials. Use this time to strengthen your resolve.\n\nYour next trial is a test of wisdom.\n\n\nPress ENTER to Close"
			
			
			get_parent().remove_child(self)
			queue_free()


func done_speaking():
	if (first_phase == true):
		get_parent().get_node("emitter").start()
	else:
		get_parent().get_node("emitter").next_phase()
