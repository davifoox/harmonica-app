extends Control

export(String) var lick_name

onready var button = $Button
onready var label = $Label
onready var audio_stream_player = $AudioStreamPlayer
onready var tags_container = $TagsContainer

const TAGS_PATH = "res://tags/tags/"
const FILE_EXTENSION = "tres"

func _ready() -> void:
	button.connect("pressed", self, "_on_button_pressed")
	get_tags_and_add_as_groups()
	label.text = lick_name
		
func _on_button_pressed():
	audio_stream_player.play()

func get_tags_and_add_as_groups():
	for tag in tags_container.tags_list:
		var tag_name = tag.resource_path
		
		tag_name = tag_name.lstrip(TAGS_PATH)
		tag_name = tag_name.rstrip(FILE_EXTENSION)
		tag_name = tag_name.rstrip(".")
		
		add_to_group(tag_name)
		print(tag_name)
