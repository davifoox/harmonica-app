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

func _ready() -> void:
	audio_files_list = Util.load_files_paths(AUDIO_FOLDER_PATH)
	
	for audio_file in audio_files_list:
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
	

func _on_lick_started_playing(node_name):
	for lick in licks_container.get_children():
		if lick.name != node_name:
			if lick.audio_stream_player.playing:
				lick.audio_stream_player.stop()
				
func _on_KeyController_key_changed(key_name: String, pitch : float):
	for lick in licks_container.get_children():
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
		if lick.file_name in SaveManager.save.favorite_licks:
			lick.show()
		else:
			lick.hide()


func _on_NextButton_pressed() -> void:
	scroll_container_swipe.set_v_scroll(scroll_container_swipe.get_v_scroll() + 10000)


func _on_PreviousButton_pressed() -> void:
	scroll_container_swipe.set_v_scroll(scroll_container_swipe.get_v_scroll() - 10000)
