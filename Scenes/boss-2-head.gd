extends Sprite

var projectile = preload("res://Scenes/practice-projectile.tscn")

var dialogue = preload("res://Scenes/Dialogue.tscn")

var particles = preload("res://Scenes/Boss-Particles.tscn")

var health = 200

var kill_time = 60

var vulnerable = false

var started_moving = false

# Called when the node enters the scene tree for the first time.
func _ready():
	var d = dialogue.instance()
	add_child(d)
	d.messages = ["I am the test of wisdom", "Use the E key to drink a potion", "One will make me vulnerable.", "The rest will cause unendurable pain.", "Choose wisely."]
	d.start_dialogue()
	
	if (Global.difficulty == "impossible"):
		kill_time = 30
		
	$Label.text = str(int(kill_time))
	
func start_time():
	$KillTimer.set_wait_time(kill_time)
	$KillTimer.start()
	
func _process(delta):
	if (started_moving):
		$Label.text = str(int($KillTimer.time_left))
	if (vulnerable == false):
		if (get_parent().get_node("potions").get_child_count() < 16 and started_moving == false):
			start_time()
			started_moving = true
		if (get_parent().get_node("potions").get_child_count() == 0):
			vulnerable = true
			
			for c in get_children():
				if (c.name == "Dialogue"):
					c.queue_free()
					
			var d = dialogue.instance()
			add_child(d)
			d.messages = ["He drank them all? Impossible."]
			d.start_dialogue()
	
func got_hit(damage):
	if (vulnerable):
		health -= damage
		get_parent().get_node("boss-health").value = health
		
		if (health <= 0):
			var p = particles.instance()
			get_parent().add_child(p)
			p.emitting = true
			p.position = position
			
			var portal = load("res://Scenes/Portal.tscn").instance()
			get_parent().add_child(portal)
			portal.position = position
			
			var bookstacks = load("res://Scenes/Bookstacks.tscn").instance()
			get_parent().add_child(bookstacks)
			bookstacks.position = position + Vector2(0, -35)
			bookstacks.get_node("book-info").text = "This was not so much a test of wisdom as a test of resolve and grit. The potions you have consumed would have killed an entire army.\n\nIf you are alive, then you may be the best of us. Should you have the desire to face the final seal that lies ahead, it will test your strength in a far different way than this trial has.\n\n\nPress ENTER to Close"
			
			
			get_parent().remove_child(self)
			queue_free()
			
func done_speaking():
	if (started_moving == false):
		started_moving = true
		start_time()


func _on_KillTimer_timeout():
	Global.character_death_position = get_parent().get_node("Player").position
	get_tree().change_scene("res://Scenes/Player-Death.tscn")
