extends Node2D

var amplitude = 0

onready var camera = get_parent()

func start(duration = .2, frequency = 12, amplitude = 4):
	self.amplitude = amplitude
	
	$Duration.wait_time = duration
	$Frequency.wait_time = 1 / float(frequency)
	$Duration.start()
	$Frequency.start()
	pass
	
func new_shake():
	var rand = Vector2()
	rand.x = rand_range(-amplitude, amplitude)
	rand.y = rand_range(-amplitude, amplitude)
	
	$Tween.interpolate_property(camera, "offset", camera.offset, rand, $Frequency.wait_time, Tween.TRANS_QUINT, Tween.EASE_OUT)
	$Tween.start()
	
func reset():
	$Tween.interpolate_property(camera, "offset", camera.offset, Vector2(), $Frequency.wait_time, Tween.TRANS_QUINT, Tween.EASE_OUT)
	$Tween.start()


func _on_Frequency_timeout():
	new_shake()

func _on_Duration_timeout():
	reset()
	$Frequency.stop()
