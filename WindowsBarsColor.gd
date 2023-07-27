extends Node

func _ready() -> void:
	set_windows_bars_color()

func set_windows_bars_color():
	var black_bar_texture = preload("res://bars-color.png")
	var t_id = black_bar_texture.get_rid()
	VisualServer.black_bars_set_images(t_id, t_id, t_id, t_id)
