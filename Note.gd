extends Sprite

var _timer = null
var _up = false

func _ready():
	GameEvents.connect("mitch_close_to_note", self, "_on_mitch_close_to_note")
	GameEvents.connect("mitch_far_from_note", self, "_on_mitch_far_from_note")
	
	_timer = Timer.new()
	add_child(_timer)

	_timer.connect("timeout", self, "_on_Timer_timeout")
	_timer.set_wait_time(0.5)
	_timer.set_one_shot(false) # Make sure it loops
	_timer.start()


func _on_Timer_timeout():
	if _up:
		_up = false
		$DownArrow.translate(Vector2(0, 1))
	else:
		_up = true
		$DownArrow.translate(Vector2(0, -1))


func _on_mitch_far_from_note():
	$DownArrow.visible = false


func _on_mitch_close_to_note():
	$DownArrow.visible = true
