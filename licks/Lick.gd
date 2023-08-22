extends Control

onready var play_button : TextureButton = $PlayButton
onready var stop_button : TextureButton = $StopButton
onready var star_button : TextureButton = $StarButton
onready var label : Label = $Label
onready var audio_stream_player : AudioStreamPlayer = $AudioStreamPlayer
onready var h_slider : HSlider = $HSlider
onready var current_time_label : Label = $CurrentTimeLabel
onready var time_left_label : Label = $TimeLeftLabel

var file_path : String
var file_name : String

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
	file_name = current_string
	
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
#	label.text = artist_name + "\n" + music_name + "\n" + lick_name + "\n" + "Chord: " + chord_name
	label.text = music_name + "\n" + lick_name + "\n" + "Chord: " + chord_name
	lick_length = audio_stream_player.stream.get_length()
	h_slider.max_value = lick_length
	
	reset_timers()
	
	if this_lick_is_in_favorites_list():
		star_button.pressed = true

func _process(delta: float) -> void:
	if audio_stream_player.playing:
		h_slider.value = audio_stream_player.get_playback_position()
		current_time_label.text = str(Util.convert_to_number_with_2_decimals(audio_stream_player.get_playback_position()))
		time_left_label.text = str(get_time_left())

func _on_play_button_pressed():
	emit_signal("started_playing", name)
	audio_stream_player.play()

func _on_stop_button_pressed():
	audio_stream_player.stop()
	h_slider.value = 0
	reset_timers()

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

func get_time_left():
	var time_left : float
	time_left = audio_stream_player.stream.get_length() - audio_stream_player.get_playback_position()
	return Util.convert_to_number_with_2_decimals(time_left) 

func reset_timers():
	current_time_label.text = "0.0"
	time_left_label.text = str(Util.convert_to_number_with_2_decimals(lick_length))

func _on_StarButton_pressed(button_name) -> void:
	if not this_lick_is_in_favorites_list():
		SaveManager.save.favorite_licks.append(file_name)
	else:
		SaveManager.save.favorite_licks.erase(file_name)
	SaveManager.save_file()

func this_lick_is_in_favorites_list():
	return SaveManager.save.favorite_licks.has(file_name)
		
