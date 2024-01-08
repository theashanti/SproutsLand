extends Button

@onready var music : AudioStreamPlayer = $Music

func _on_pressed():
	if music.playing:
		music.stop()
	else:
		music.play()
