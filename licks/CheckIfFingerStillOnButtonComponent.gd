extends Node2D

var touch_position : Vector2
signal really_pressed(button_name)

func _ready() -> void:
	get_parent().connect("button_down", self, "_on_button_down")
	get_parent().connect("button_up", self, "_on_button_up")

func _on_button_down() -> void:
	touch_position = get_global_mouse_position()

func _on_button_up() -> void:
	var offset = 10
	if get_global_mouse_position().distance_to(touch_position) <= offset :
		emit_signal("really_pressed", get_parent().name)
