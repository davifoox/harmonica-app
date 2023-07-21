extends Node

var note_step = 0.06
export var current_note = 1
onready var audio = $AudioStreamPlayer

var key_names_list = ["LF", "Gb",  "G", "Ab", "A", "Bb",  "B",  "C", "Db",  "D", "Eb",  "E",  "F"]
var pitches_list =   [0.79, 0.84, 0.89, 0.94,   1, 1.06, 1.12, 1.18, 1.26, 1.33, 1.41, 1.49, 1.58]

func _ready() -> void:
	audio.pitch_scale = current_note

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_up"):
		current_note += note_step
		audio.pitch_scale = current_note
		audio.play()
	elif Input.is_action_just_pressed("ui_down"):
		current_note -= note_step
		audio.pitch_scale = current_note		
		audio.play()
		
	if Input.is_action_just_pressed("ui_accept"):
		audio.play()
