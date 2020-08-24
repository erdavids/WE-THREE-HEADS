extends Node2D

func _ready():
	$Player.frozen = true
	Global.game_completed = true

	$Tween.interpolate_property($Player, "position", $Player.position, Vector2($Player.position.x, 232), 2, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
