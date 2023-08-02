extends Node

var SAVE_FILE_PATH
var save : SaveFile
onready var animation_player = $SavingMessageLayer/AnimationPlayer

func _ready() -> void:
	var project_name = ProjectSettings.get_setting("application/config/name")
	SAVE_FILE_PATH = "user://" + project_name + ".tres"
	set_initial_save_file()
	
func set_initial_save_file():
	if not ResourceLoader.exists(SAVE_FILE_PATH):
		save = SaveFile.new()
		save_file()
	else:
		save = ResourceLoader.load(SAVE_FILE_PATH)
	
func save_file():
	ResourceSaver.save(SAVE_FILE_PATH, save)
	if animation_player.is_playing():
		animation_player.stop()
	animation_player.play("saving")
	
func reset_save_file():
	save = SaveFile.new()
	save_file()
