extends Control


onready var button = $Button
onready var audio_stream_player = $AudioStreamPlayer

enum tags {
	#Chord
	I,
	IV,
	V,
	
	#Music
	orangeDudeBlues
}

export(tags) var lick_tags

func _ready() -> void:
	button.connect("pressed", self, "_on_button_pressed")
	
	var tag_name = tags.keys()[tags.I]
	add_to_group(tag_name)
	print(tag_name)
	
func _on_button_pressed():
	audio_stream_player.play()
