extends Node2D

var current_dialog = null
var greyish_color = Color(.25, .25, .25)
var _mitch_close_to_note = false

func _ready():
	GameEvents.connect("mitch_close_to_note", self, "_on_mitch_close_to_note")
	GameEvents.connect("mitch_far_from_note", self, "_on_mitch_far_from_note")
	current_dialog = 1
	$AnimationPlayer.play("Intro")
	$Stuff.modulate = greyish_color
	

func _unhandled_key_input(event: InputEventKey):
	
	if event.pressed:
		match event.scancode:
			KEY_E:
				if _mitch_close_to_note:
					$Stuff.modulate = greyish_color
					$BigNote.visible = true
					$PaperMove.play()
					_end_game()
			KEY_ENTER:
				if current_dialog == 5:
					$Stuff.modulate = Color.white
					$Dialog.visible = false
				else:
					$Dialog.visible = true
					current_dialog += 1
					$Dialog.texture = load("res://dialog_intro%s.png" % current_dialog)
			KEY_ESCAPE:
				get_tree().quit()

func _on_mitch_close_to_note():
	_mitch_close_to_note = true

func _on_mitch_far_from_note():
	_mitch_close_to_note = false

func _end_game():
	yield(get_tree().create_timer(4), "timeout")
	self.modulate = Color(0, 0, 0)
	$Music.stop()
	yield(get_tree().create_timer(.5), "timeout")
	OS.alert('File not found: dad.png', 'Error')
	get_tree().quit()

