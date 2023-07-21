extends Control

var audio_files_list = []
var lick_scene = preload("res://licks/Lick.tscn")
onready var licks_container = $ScrollContainerSwipe/LicksContainer
const AUDIO_FOLDER_PATH = "res://licks/audio/"
onready var key_controller = $KeyController

func _ready() -> void:
	audio_files_list = Util.load_files_paths(AUDIO_FOLDER_PATH)
	
	for audio_file in audio_files_list:
		var l = lick_scene.instance()
		l.init(audio_file)
		licks_container.add_child(l)
		l.connect("started_playing", self, "_on_lick_started_playing")
	
	key_controller.connect("key_changed", self, "_on_KeyController_key_changed")

func _on_lick_started_playing(node_name):
	for lick in licks_container.get_children():
		if lick.name != node_name:
			if lick.audio_stream_player.playing:
				lick.audio_stream_player.stop()
				
func _on_KeyController_key_changed(key_name: String, pitch : float):
	for lick in licks_container.get_children():
		lick.audio_stream_player.pitch_scale = pitch
