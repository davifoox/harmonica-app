extends Control

var audio_files_list = []
var lick_scene = preload("res://licks/Lick.tscn")
onready var licks_container = $ScrollContainerSwipe/LicksContainer
const AUDIO_FOLDER_PATH = "res://licks/audio/"

func _ready() -> void:
	var audio_files_list = Util.get_list_of_files_in_folder("res://licks/audio/")
	for audio_file in audio_files_list:
		var l = lick_scene.instance()
		l.init(AUDIO_FOLDER_PATH, audio_file)
		licks_container.add_child(l)
