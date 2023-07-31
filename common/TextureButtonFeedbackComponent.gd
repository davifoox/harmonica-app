extends Node
class_name ButtonFeedbackComponent

onready var texture_button

export var visual_feedback = true
export var sound_feedback = true
export var haptic_feedback = true

func _ready() -> void:
	texture_button = get_parent()
	texture_button.connect("button_down", self, "_on_parent_button_down")
	texture_button.connect("button_up", self, "_on_parent_button_up")
	texture_button.connect("mouse_entered", self, "_on_parent_mouse_entered")
	texture_button.connect("mouse_exited", self, "_on_parent_mouse_exited")
	
func _on_parent_button_down() -> void:
	update_visual("5d5d5d")
#	play_sound(Enums.UI_ACCEPT)
	#TODO: add vibration here

func _on_parent_button_up() -> void:
	update_visual()

func _on_parent_mouse_entered() -> void:
	update_visual("b8b8b8")

func _on_parent_mouse_exited() -> void:
	update_visual()

func update_visual(color_value : String = "ffffff"):
	if visual_feedback:
		texture_button.modulate = color_value

#func play_sound(sound_enum : int):
#	if sound_feedback:
#		GameSignals.emit_signal("ui_used", sound_enum, haptic_feedback)
