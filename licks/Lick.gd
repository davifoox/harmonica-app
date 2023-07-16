extends Control

onready var button : Button = $Button
onready var label : Label = $Label
onready var audio_stream_player : AudioStreamPlayer = $AudioStreamPlayer

var file_name : String
var music_name : String
var artist_name : String
var chord_name : String

func init(folder_path : String, audio_file_path : String):
	file_name = audio_file_path
	$AudioStreamPlayer.stream = load(folder_path + file_name)

func _ready() -> void:
	button.connect("pressed", self, "_on_button_pressed")
		
func _on_button_pressed():
	audio_stream_player.play()

func get_tags_and_add_as_groups():
	pass

func get_name_from_file():
	var FILE_EXTENSION = "mp3"
	
	file_name = file_name.rstrip(FILE_EXTENSION)
	file_name = file_name.rstrip(".")
	
