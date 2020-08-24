extends Node2D

var dir = Vector2.ZERO

var SPEED = 200

var damage = 4

var particles = preload("res://Scenes/Spell-Particles.tscn")

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	position += dir * SPEED * delta

func spawn_particles():
	var p = particles.instance()
	p.emitting = true
	p.position = position
	get_parent().add_child(p)

func _on_Area2D_area_entered(area):
	if (area.get_parent().name != "Player"):
		if ("collide" in area.name):
			if ("boss" in area.name):
				area.get_parent().got_hit(damage)
			spawn_particles()
			queue_free()
		if ("dice" in area.name):
			area.get_parent().reroll()


func _on_Area2D_body_entered(body):
	if (body.name != "Player"):
		spawn_particles()
		queue_free()
		
