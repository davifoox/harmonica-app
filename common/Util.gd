class_name Util

static func convert_index_to_enum_name(index : int, which_enum) -> String:
	return which_enum.keys()[index]

static func load_files_paths(path):
	var files_list = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin()
	
	while true:
		var file_name = dir.get_next()
		if file_name == "":
			break
			
		elif !file_name.begins_with(".") and file_name.ends_with(".import"):
			file_name = file_name.replace('.import', '')
			files_list.append(path + file_name)
				
	dir.list_dir_end()
	return files_list

static func convert_to_number_with_2_decimals(float_number):
	return stepify(float_number, 0.01)

static func has_letters(your_string):
	var regex = RegEx.new()
	regex.compile("[a-zA-Z]+")
	if regex.search(str(your_string)):
		return true
	else:
		return false

static func remove_last_character_from_string(your_string):
	return your_string.left(your_string.length() - 1)

static func calculate_percentage_of_numberA_according_to_numberB(num_a, num_b):
	return (100 * num_a) / num_b

static func calculate_X_percentage_of_Y(num_x, num_y):
	return (num_y / 100) * num_x
