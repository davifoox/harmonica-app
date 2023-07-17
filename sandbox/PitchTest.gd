extends Node

var note_step = 0.06
export var current_note = 1
onready var audio = $AudioStreamPlayer

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
