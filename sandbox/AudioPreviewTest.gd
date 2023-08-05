extends Node2D

var spectrum_texture: ImageTexture
var spectrum_sprite: Sprite

func _ready():
	var spectrum_image = Image.new()
	spectrum_image.create(512, 256, false, Image.FORMAT_RGBA8)
	spectrum_image.lock()

	for y in range(spectrum_image.get_height()):
		var intensity = 1.0 - float(y) / float(spectrum_image.get_height())
		
		for x in range(spectrum_image.get_width()):
			var value = abs(sin(x * 0.1) * intensity)
			value *= pow(intensity, 0.5)
			value *= rand_range(0.5, 1.5)  # Vary bar heights
			value = clamp(value, 0.0, 1.0)
			var color = Color(value, value * 0.5, value * 0.2)
			spectrum_image.set_pixel(x, y, color)

	spectrum_image.unlock()

	spectrum_texture = ImageTexture.new()
	spectrum_texture.create_from_image(spectrum_image)
	
	spectrum_sprite = Sprite.new()
	spectrum_sprite.texture = spectrum_texture
	add_child(spectrum_sprite)

	spectrum_sprite.scale.x = 2.0  # Adjust the scale for better visibility
	spectrum_sprite.scale.y = 2.0

	spectrum_sprite.position.x = get_viewport_rect().size.x / 2
	spectrum_sprite.position.y = get_viewport_rect().size.y / 2
