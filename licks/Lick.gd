extends Control

onready var button : Button = $Button
onready var label : Label = $Label
onready var audio_stream_player : AudioStreamPlayer = $AudioStreamPlayer

var file_path : String
var artist_name : String
var music_name : String
var lick_name : String
var chord_name : String

signal started_playing(node_name)

func init(folder_path : String, audio_file_path : String):
	file_path = folder_path + audio_file_path
	
	var current_string = audio_file_path.rstrip(".mp3")
	var string_array = current_string.rsplit("-", true, 3)
	
	artist_name = string_array[0]
	music_name = string_array[1]
	lick_name = string_array[2]
	chord_name = "Chord: " + string_array[3]

func _ready() -> void:
	button.connect("pressed", self, "_on_button_pressed")
	audio_stream_player.stream = load(file_path)
	label.text = artist_name + "\n" + music_name + "\n" + lick_name + "\n" + chord_name
		
func _on_button_pressed():
	emit_signal("started_playing", name)
	audio_stream_player.play()

func get_tags_and_add_as_groups():
	pass

func get_name_from_file():
	var FILE_EXTENSION = "mp3"
	
	file_path = file_path.rstrip(FILE_EXTENSION)
	file_path = file_path.rstrip(".")
	
