extends Control

var audio_files_list = []

func _ready() -> void:
	var audio_files_list = Util.get_list_of_files_in_folder("res://licks/audio/")
	print(audio_files_list.size())
