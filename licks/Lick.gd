extends Control

onready var button = $Button
onready var label = $Label
onready var audio_stream_player = $AudioStreamPlayer
var file_name : String

func init(mp3_file):
	pass

func _ready() -> void:
	button.connect("pressed", self, "_on_button_pressed")
	get_name_from_file()
	print(file_name)
		
func _on_button_pressed():
	audio_stream_player.play()

func get_tags_and_add_as_groups():
	pass

func get_name_from_file():
	var LICKS_PATH = "res://licks/audio/"
	var FILE_EXTENSION = "mp3"
	
	file_name = filename
	file_name = file_name.lstrip(LICKS_PATH)
	file_name = file_name.rstrip(FILE_EXTENSION)
	file_name = file_name.rstrip(".")
	
