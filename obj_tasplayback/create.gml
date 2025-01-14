function play_next_input() {
	// Check if we arent at the end of the TAS yet
	if current_frame < frames
	{
		var current_inputs = tas[current_frame]
		var current_inputs_len = array_length_1d(current_inputs)

		// Pressing
		for (var i=0; i<current_inputs_len; i++)
		{
			var keycode = current_inputs[i]

			if not keyboard_check(keycode)
			{
				keyboard_key_press(keycode)
				show_debug_message(concat("PRESSED ", keycode))
			}
		}

		// Releasing
		if current_frame-1 >= 0 // Check if we are not at the start of the file
		{
			var previous_inputs = tas[current_frame-1]
			var previous_inputs_len = array_length_1d(previous_inputs)

			// Loop through previous inputs
			for (var p=0; p<previous_inputs_len; p++)
			{
				var prev_keycode = previous_inputs[p]
				var should_release = true

				// Check current inputs
				for (var i=0; i<current_inputs_len; i++)
				{
					var current_keycode = current_inputs[i]
					if current_keycode == prev_keycode
					{
						should_release = false
						break
					}
				}

				if should_release 
				{
					keyboard_key_release(prev_keycode);
					show_debug_message(concat("RELEASED ", prev_keycode))
				} 
			}
		}
	}
	else
	{
		mode = 0 // stop playback
	}
}

tas = [] // Usage: global.tas[frame]
tas_path = ""
frames = 0
mode = 0 // 0: No tas, 1: Recording, 2: Playback
current_frame = 0
ignore_keys = [
	global.taskey_toggle_unbound_camera,
	global.taskey_toggle_collision,
	global.taskey_toggle_stats,
	global.taskey_toggle_bounding_boxes,
	global.taskey_toggle_show_everything,
	global.taskey_pause,
	global.taskey_frameadvance,
	global.taskey_savestate,
	global.taskey_loadstate,
	global.taskey_save_tas
	]

// pausing
keys_when_paused = []
frame_advance = false

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

frames = array_length_1d(tas) // update the frame count

// stinky HACK to avoid the tas from being delayed
if mode == 2 {
	play_next_input()
	current_frame++
}