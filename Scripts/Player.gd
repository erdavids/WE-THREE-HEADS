extends KinematicBody2D

const Acceleration = 1000
const Max_Speed = 12000
const Friction = 2000

var velocity = Vector2.ZERO

var projectile = preload("res://Scenes/Player-Spell.tscn")
var reflection = preload("res://Scenes/Reflector.tscn")

var dialogue = preload("res://Scenes/Dialogue.tscn")
var scroll = preload("res://Scenes/Scroll.tscn")

var frozen = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
#	var d = dialogue.instance()
#	add_child(d)
#	d.messages = ["Wait for an adventurer...", ".....", "I've waited 1200 years...", "I'll do it myself"]
#	d.start_dialogue()

func _process(delta):
	
	if (Input.is_action_just_pressed("ui_cancel")):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		if (get_tree().current_scene.get_name() != "HowTo"):
			var pause = load("res://Scenes/Pause.tscn").instance()
			get_parent().add_child(pause)
			get_tree().paused = true
	if (frozen == false):
		if (Input.is_action_just_pressed("fire")):
			if (get_tree().get_current_scene().get_name() == "Boss-4"):
				get_parent().get_node("boss-wife").final_word()
			else:
				var p = projectile.instance()
				p.global_position = position
				p.dir = (get_global_mouse_position() - p.global_position).normalized()
		#		p.dir = ($Cursor.position - position).normalized()
				p.rotation = p.dir.angle()
				get_parent().add_child(p)
				
				$"fire-noise".playing = true
		
		if (Input.is_action_just_pressed("reflect")):
			var r = reflection.instance()
			add_child(r)
			
			for a in $Influence.get_overlapping_areas():
				if ("projectile" in a.name):
					a.get_parent().SPEED = a.get_parent().SPEED * 1.4
					a.get_parent().dir = (get_global_mouse_position() - a.global_position).normalized()
					a.get_parent().spin = true
					a.get_parent().hurt_enemy = true
					a.get_parent().hurt_player = false
					
					$"reflect-noise".playing = true

		if (Input.is_action_just_pressed("Info")):
			for a in $Influence.get_overlapping_areas():
				if ("info" in a.name):
					frozen = true
					var s = scroll.instance()
					s.set_text(a.text)
					get_parent().add_child(s)
					
					$"page-noise".playing = true
					
				if ("potion" in a.name):
					for p in get_parent().get_node("potions").get_children():
						p.SPEED += 10
					a.get_parent().queue_free()
					$Potion.playing = true

func _physics_process(delta):
	$Cursor.position = get_local_mouse_position()
	if (frozen == false):
		# REVISIT this for better aiming, works for now
		
		var input_vector = Vector2.ZERO
		
		input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		
		input_vector = input_vector.normalized()
		
		if input_vector != Vector2.ZERO:
			velocity += input_vector * Acceleration * delta
			velocity = velocity.clamped(Max_Speed * delta)
			
		else:
			velocity = velocity.move_toward(Vector2.ZERO, Friction * delta)
		move_and_slide(velocity)
func got_hit():
	Global.lives -= 1
	if (Global.lives <= 0):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		Global.character_death_position = position
		get_tree().change_scene("res://Scenes/Player-Death.tscn")

	
func _on_Influence_area_entered(area):
	pass
	
func switch_forms():
	$Sprite.texture = load("res://Assets/true-form.png")
	$FormTimer.set_wait_time(.3)
	$FormTimer.one_shot = true
	$FormTimer.start()
			



func _on_FormTimer_timeout():
	$Sprite.texture = load("res://Assets/player-idle.png")


func _on_portal_area_area_entered(area):
	if ("portal" in area.name):
		if (Global.game_completed == false):
			Global.current_level += 1
			get_tree().change_scene("res://Scenes/Boss-" + str(Global.current_level) + ".tscn")
		else:
			get_tree().change_scene("res://Scenes/Ending.tscn")
