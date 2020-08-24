extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Tween.interpolate_property(self, "position", position, Vector2(0, -320), 2, Tween.TRANS_QUINT, Tween.EASE_OUT)
	$Tween.start()

func set_text(t):
	$Label.text = t

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed("ui_accept")):
		get_parent().get_node("Player").frozen = false
		queue_free()
