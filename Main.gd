extends Control

var audio_files_list = []
var lick_scene = preload("res://licks/Lick.tscn")
onready var licks_container = $ScrollContainerSwipe/LicksContainer
onready var scroll_container_swipe = $ScrollContainerSwipe 
const AUDIO_FOLDER_PATH = "res://licks/audio/"
onready var key_controller = $KeyController

onready var all_chords_button = $GroupsSelection/AllChordsButton
onready var chord_I_button = $GroupsSelection/ChordIButton
onready var chord_IV_button = $GroupsSelection/ChordIVButton
onready var chord_V_button = $GroupsSelection/ChordVButton
onready var star_button = $GroupsSelection/StarButton
onready var random_button = $GroupsSelection/RandomButton

func _ready() -> void:
	audio_files_list = Util.load_files_paths(AUDIO_FOLDER_PATH)
	
	var artist_name = ""
	for audio_file in audio_files_list:
		if artist_name != get_artist_name_from_file(audio_file):
			artist_name = get_artist_name_from_file(audio_file)
			var label = Label.new()
			label.text = artist_name
			licks_container.add_child(label)
			
		var l = lick_scene.instance()
		l.init(audio_file)
		licks_container.add_child(l)
		l.connect("started_playing", self, "_on_lick_started_playing")
	
	key_controller.connect("key_changed", self, "_on_KeyController_key_changed")
	all_chords_button.connect("pressed", self, "_on_AllChordsButton_pressed")
	chord_I_button.connect("pressed", self, "_on_ChordIButton_pressed")
	chord_IV_button.connect("pressed", self, "_on_ChordIVButton_pressed")
	chord_V_button.connect("pressed", self, "_on_ChordVButton_pressed")
	star_button.connect("pressed", self, "_on_StarButton_pressed")
	random_button.connect("pressed", self, "_on_RandomButton_pressed")
	

func _on_lick_started_playing(node_name):
	for lick in licks_container.get_children():
		if lick.name != node_name and !(lick is Label):
			if lick.audio_stream_player.playing:
				lick.audio_stream_player.stop()
				
func _on_KeyController_key_changed(key_name: String, pitch : float):
	for lick in licks_container.get_children():
		if !(lick is Label):
			lick.audio_stream_player.pitch_scale = pitch


func _on_AllChordsButton_pressed() -> void:
	for lick in licks_container.get_children():
		lick.show()

func _on_ChordIButton_pressed() -> void:
	for lick in licks_container.get_children():
		if lick.is_in_group("I"):
			lick.show()
		else:
			lick.hide()

func _on_ChordIVButton_pressed() -> void:
	for lick in licks_container.get_children():
		if lick.is_in_group("IV"):
			lick.show()
		else:
			lick.hide()

func _on_ChordVButton_pressed() -> void:
	for lick in licks_container.get_children():
		if lick.is_in_group("V"):
			lick.show()
		else:
			lick.hide()

func _on_StarButton_pressed() -> void:
	for lick in licks_container.get_children():
		if !(lick is Label):
			if lick.file_name in SaveManager.save.favorite_licks:
				lick.show()
			else:
				lick.hide()

func _on_RandomButton_pressed():
	var licks_amount : int = licks_container.get_children().size()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var random_number = rng.randi_range(0, licks_amount)
	
	for i in range(0, licks_amount):
		if i == random_number:
			licks_container.get_child(i).show()
		else:
			licks_container.get_child(i).hide()

func _on_NextButton_pressed() -> void:
	scroll_container_swipe.set_v_scroll(scroll_container_swipe.get_v_scroll() + 10000)


func _on_PreviousButton_pressed() -> void:
	scroll_container_swipe.set_v_scroll(scroll_container_swipe.get_v_scroll() - 10000)

func get_artist_name_from_file(file_path):
	var artist_name = file_path.lstrip("res://licks/audio/")
	artist_name = artist_name.rstrip(".mp3")
	var string_array = artist_name.rsplit("-", true, 3)
	artist_name = string_array[0].replace("_"," ") 
	return artist_name
