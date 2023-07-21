extends Control

export var current_key = 4
onready var audio = $AudioStreamPlayer
onready var key_label = $KeyLabel

signal key_changed(key_name, pitch)
var key_names_list = ["LF", "Gb",  "G", "Ab", "A", "Bb",  "B",  "C", "Db",  "D", "Eb",  "E",  "F"]
var pitches_list =   [0.79, 0.84, 0.89, 0.94,   1, 1.06, 1.12, 1.18, 1.26, 1.33, 1.41, 1.49, 1.58]

func _ready() -> void:
	audio.pitch_scale = pitches_list[current_key]

func _on_ButtonPlus_pressed() -> void:
	change_note(1)

func _on_ButtonMinus_pressed() -> void:
	change_note(-1)

func change_note(step : int):
	current_key += step
	current_key = clamp(current_key, 0, key_names_list.size()-1)
	emit_signal("key_changed", key_names_list[current_key], pitches_list[current_key])
	
	key_label.text = key_names_list[current_key]
	audio.pitch_scale = pitches_list[current_key]
	audio.play()
