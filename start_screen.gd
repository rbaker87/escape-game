extends Control


func _input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			# Start the background music
			BackgroundMusic.play()

			# Transition to first room
			get_tree().change_scene_to_file("res://rooms/room1.tscn")
