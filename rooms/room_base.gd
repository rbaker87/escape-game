extends Control

@export var dialogue_resource: DialogueResource
@export var next_scene_path: String = ""

@export var show_sprite: Sprite2D

var waiting_for_click: bool = false


func _ready():
	Autoloads.clue_count = 1
	gui_input.connect(_on_background_input)
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	DialogueManager.passed_title.connect(_on_passed_title)

	# Auto-start dialogue
	await get_tree().process_frame
	DialogueManager.show_dialogue_balloon_scene(
		"res://dialogue/balloon.tscn",
		dialogue_resource,
		"start"
	)


func _on_passed_title(title: String):
	# When we reach the "bear" section, show the sprite
	if title == "bear" and show_sprite:
		show_sprite.visible = true


func _on_dialogue_ended(resource: DialogueResource):
	if resource == dialogue_resource:
		# Only enable click detection if not the final room
		if not next_scene_path.is_empty():
			waiting_for_click = true


func _on_background_input(event: InputEvent):
	if not waiting_for_click:
		return

	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			waiting_for_click = false
			if Autoloads.clue_count < 3:
				Autoloads.clue_count += 1
			else:
				Autoloads.clue_count = 1
			DialogueManager.show_dialogue_balloon_scene(
				"res://dialogue/balloon.tscn",
				dialogue_resource,
				"fail"
			)


func _on_test_button_pressed():
	waiting_for_click = false

	if next_scene_path.is_empty():
		get_tree().quit()
	else:
		get_tree().change_scene_to_file(next_scene_path)
