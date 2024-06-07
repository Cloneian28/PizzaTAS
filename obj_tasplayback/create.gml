tas = [] // Usage: global.tas[frame]
tas_path = ""
frames = 0
mode = 0 // 0: No tas, 1: Recording, 2: Playback
current_frame = 0

global.tas_paused = false

ignore_keys = [ord("P"), vk_f6, vk_f7]

// Read the config file
if file_exists("tasconfig.ini")
{
	var config = ini_open("tasconfig.ini")

	mode = ini_read_real("TAS", "mode", 2)

	// Reading the tas
	tas_path = ini_read_string("TAS", "path", "")
	if file_exists(tas_path) && mode == 2
	{
		// Taken from https://www.reddit.com/r/gamemaker/comments/owann0/way_to_load_a_text_file_into_a_string_fast_in_gml/
		var file_buffer = buffer_load(tas_path);

		var tas_string = buffer_read(file_buffer, buffer_string);
		buffer_delete(file_buffer);
		
		// Now we will decode the TAS fom the string
		var split_string = string_split(tas_string, "\n")
		var splits = array_length_1d(split_string)

		for (var i=0; i<splits; i++)
		{
			var unconverted_inputs = string_split(split_string[i], ",")
			var inputs = array_length_1d(unconverted_inputs)

			// Converts all inputs into keycodes
			var converted_inputs = []
			for (var b=0; b<inputs; b++)
			{	
				var digits = string_digits(unconverted_inputs[b])
				if digits != ""
				{
					converted_inputs[b] = real(digits)
				}
			}

			// Now we add the converted inputs to the tas
			tas[i] = converted_inputs
		}

		show_debug_message("Tas loaded")
		show_debug_message(concat("Frames: ", frames))
	}

	ini_close()
}