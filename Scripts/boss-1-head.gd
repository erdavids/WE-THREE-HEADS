extends Sprite

var projectile = preload("res://Scenes/practice-projectile.tscn")

var dialogue = preload("res://Scenes/Dialogue.tscn")
var particles = preload("res://Scenes/Boss-Particles.tscn")

var starting_health = 500
var health = 500

var vulnerable = false

var first_phase = true

# Called when the node enters the scene tree for the first time.
func _ready():
	var d = dialogue.instance()
	add_child(d)
	d.messages = ["I am the final seal", "I will test your strength"]
	d.start_dialogue()
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func move(target):
	$Tween.interpolate_property(self, "position", position, target, 1.5, Tween.TRANS_QUINT, Tween.EASE_OUT)
	$Tween.start()
	
func _process(delta):
	var dice_states = []
	for d in get_parent().get_node("Dice").get_children():
		dice_states.append(d.state)
		
	if (dice_states[0] == dice_states[1] and dice_states[2] == dice_states[3] and dice_states[1] == dice_states[2]):
		vulnerable = true
	else:
		vulnerable = false
	
func _on_MoveTimer_timeout():
	var target = Vector2(rand_range(80, 400), rand_range(80, 240))
	move(target)
	
func got_hit(damage):
	if (vulnerable):
		health -= damage
		get_parent().get_node("boss-health").value = health

		if (health <= starting_health/2 and first_phase):
			var d = dialogue.instance()
			add_child(d)
			d.messages = ["Enough."]
			d.start_dialogue()
			
			for c in get_parent().get_children():
				if ("projectile" in c.name):
					if (c != null):
						var p = load("res://Scenes/Sword-Particles.tscn").instance()
						p.emitting = true
						p.position = c.position
						get_parent().add_child(p)
						c.queue_free()

			first_phase = false
		
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
			bookstacks.position = position + Vector2(0, -30)
			bookstacks.get_node("book-info").text = "To the traveler who has defeated the final seal...\n\nYou must have strength beyond any of us. The seals have tested you greatly and found you worthy to face what lies ahead.\n\nIf it is that you intend to release the creature you march towards... I hope that you will reconsider before the end of your path.\n\n\nPress ENTER to Close"
			
			get_parent().remove_child(self)
			queue_free()


func _on_ShootTimer_timeout():
		var p = projectile.instance()
		p.global_position = position
		p.dir = (get_parent().get_node("Player").position - p.global_position).normalized()
#		p.dir = ($Cursor.position - position).normalized()
		p.rotation = p.dir.angle()
		get_parent().add_child(p)

func done_speaking():
	if (first_phase):
		$MoveTimer.set_wait_time(3)
		$MoveTimer.start()
		
		$ShootTimer.set_wait_time(2)
		$ShootTimer.start()
	else:
		for die in get_parent().get_node("Dice").get_children():
			var p = projectile.instance()
			p.global_position = position
			p.dir = (die.position - p.global_position).normalized()
			p.rotation = p.dir.angle()
			get_parent().add_child(p)
	
