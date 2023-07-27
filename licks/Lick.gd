extends Control

onready var play_button : Button = $PlayButton
onready var stop_button : Button = $StopButton
onready var label : Label = $Label
onready var audio_stream_player : AudioStreamPlayer = $AudioStreamPlayer
onready var h_slider : HSlider = $HSlider

var file_path : String
var artist_name : String
var music_name : String
var lick_name : String
var chord_name : String

signal started_playing(node_name)
var lick_length : float

func init(audio_file_path : String):
	file_path = audio_file_path
	
	var current_string = audio_file_path.lstrip("res://licks/audio/")
	current_string = current_string.rstrip(".mp3")
	
	var string_array = current_string.rsplit("-", true, 3)
	
	artist_name = string_array[0].replace("_"," ")
	music_name = string_array[1].replace("_"," ")
	lick_name = string_array[2].replace("_"," ")
	chord_name = string_array[3].replace("_"," ")
	
	get_tags_and_add_as_groups()

func _ready() -> void:
	play_button.connect("pressed", self, "_on_play_button_pressed")
	stop_button.connect("pressed", self, "_on_stop_button_pressed")
	audio_stream_player.stream = load(file_path)
	label.text = artist_name + "\n" + music_name + "\n" + lick_name + "\n" + "Chord: " + chord_name
	lick_length = audio_stream_player.stream.get_length()
	h_slider.max_value = lick_length
	
func _process(delta: float) -> void:
	if audio_stream_player.playing:
		h_slider.value = audio_stream_player.get_playback_position()

		
func _on_play_button_pressed():
	emit_signal("started_playing", name)
	audio_stream_player.play()

func _on_stop_button_pressed():
	audio_stream_player.stop()
	h_slider.value = 0

func get_tags_and_add_as_groups():
	add_to_group(chord_name)

func get_name_from_file():
	var FILE_EXTENSION = "mp3"
	
	file_path = file_path.rstrip(FILE_EXTENSION)
	file_path = file_path.rstrip(".")
	
func _on_HSlider_drag_started() -> void:
	audio_stream_player.stop()
	
func _on_HSlider_drag_ended(value_changed: bool) -> void:
	audio_stream_player.play(h_slider.value)
	emit_signal("started_playing", name)
