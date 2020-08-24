extends Node2D

var dir = Vector2.ZERO

var spin = false

var SPEED = 200

var hurt_enemy = false
var hurt_player = true

var damage = 20

var spin_speed = 0


var particles = preload("res://Scenes/Sword-Particles.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	if (Global.difficulty == "impossible"):
		SPEED = 210
	else:
		SPEED = 140
	spin_speed = rand_range(10, 30)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += dir * SPEED * delta
	
	if (spin):
		rotate(spin_speed * delta)



func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
func stop_spinning():
	dir = Vector2.ZERO
	spin = false
	hurt_player = false

func spawn_particles():
	var p = particles.instance()
	p.emitting = true
	p.position = position
	get_parent().add_child(p)
	
	var sword_broken = load("res://Scenes/broken-sword.tscn").instance()
	get_parent().add_child(sword_broken)
	
	get_parent().remove_child(self)
	queue_free()
	

func _on_projectile_body_entered(body):
	if (body.name == "Player"):
		if (hurt_player):
			body.got_hit()
			body.switch_forms()
			spawn_particles()
	else:
		# Do damage
		stop_spinning()
		

func _on_projectile_area_entered(area):
	if ("boss" in area.name):
		if (hurt_enemy == true):
			area.get_parent().got_hit(damage)
			# Particles
			spawn_particles()
	elif ("ignore" in area.name):
		spawn_particles()
	elif ("collide" in area.name):
		if("dice" in area.name):
			area.get_parent().reroll()
		stop_spinning()

