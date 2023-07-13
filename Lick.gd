extends Control


onready var button = $Button
onready var audio_stream_player = $AudioStreamPlayer

func _ready() -> void:
	button.connect("pressed", self, "_on_button_pressed")
	
func _on_button_pressed():
	audio_stream_player.play()
