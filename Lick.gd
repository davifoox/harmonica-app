extends Control

onready var button = $Button
onready var label = $Label
onready var audio_stream_player = $AudioStreamPlayer
onready var tags_container = $TagsContainer

func _ready() -> void:
	button.connect("pressed", self, "_on_button_pressed")
	get_tags_and_add_as_groups()
	label.text = name #get name from file, same as tags
		
func _on_button_pressed():
	audio_stream_player.play()

func get_tags_and_add_as_groups():
	var TAGS_PATH = "res://tags/tags/"
	var FILE_EXTENSION = "tres"
	for tag in tags_container.tags_list:
		var tag_name = tag.resource_path
		
		tag_name = tag_name.lstrip(TAGS_PATH)
		tag_name = tag_name.rstrip(FILE_EXTENSION)
		tag_name = tag_name.rstrip(".")
		
		add_to_group(tag_name)
		print(tag_name)
