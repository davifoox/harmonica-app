class_name Util

static func convert_index_to_enum_name(index : int, which_enum) -> String:
	return which_enum.keys()[index]
	
static func get_list_of_files_in_folder(folder_path, file_extension = ".import"):
	var total = 0
	var dir = Directory.new()
	var files_list = []
	if dir.open(folder_path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if !dir.current_is_dir():
				if file_name.find(file_extension) == -1:
					total += 1
					files_list.append(file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	return files_list

static func count_files_in_folder(folder_path, file_extension = ".import"):
	var total = 0
	var dir = Directory.new()
	if dir.open(folder_path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if !dir.current_is_dir():
				if file_name.find(file_extension) == -1:
					total += 1
					print(file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	return total

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
