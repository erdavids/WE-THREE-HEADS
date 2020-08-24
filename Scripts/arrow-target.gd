extends Sprite

var boss_damage = 5
var boss_heal = -10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func hit_boss(damage):
	get_parent().get_parent().get_node("boss-head").got_hit(damage)
	
func play_sound():
	var click = load("res://Scenes/arrow-click.tscn").instance()
	get_parent().add_child(click)

func _process(delta):
	rotate(5 * delta)
	
	if (len($target.get_overlapping_areas()) > 0):
		for a in $target.get_overlapping_areas():
			if ("arrow" in a.name):
				if (Input.is_action_just_pressed("ui_down")):
					if (a.get_parent().state == 0):
						a.get_parent().destroy()
						hit_boss(boss_damage)
						play_sound()
					else:
						hit_boss(boss_heal)
				if (Input.is_action_just_pressed("ui_left")):
					if (a.get_parent().state == 1):
						a.get_parent().destroy()
						hit_boss(boss_damage)
						play_sound()
					else:
						hit_boss(boss_heal)
				if (Input.is_action_just_pressed("ui_up")):
					if (a.get_parent().state == 2):
						a.get_parent().destroy()
						hit_boss(boss_damage)
						play_sound()
					else:
						hit_boss(boss_heal)
				if (Input.is_action_just_pressed("ui_right")):
					if (a.get_parent().state == 3):
						a.get_parent().destroy()
						hit_boss(boss_damage)
						play_sound()
					else:
						hit_boss(boss_heal)
