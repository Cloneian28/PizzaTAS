/* CREATE EVENT */
tas = [] // An array containing arrays of inputs for their respective frame, Usage: global.tas[frame]
frames = 0 // The amount of frames in the tas
mode = 0 // The mode of the tas, 0: No tas, 1: Recording, 2: Playback
current_frame = 0 // The current frame in the tas, this will increase every frame

global.tas_paused = false
frame_advance = true

// Read the config file
if file_exists("tasconfig.ini")
{
	var config = ini_open("tasconfig.ini")

	mode = ini_read_real("TAS", "mode", 2) // Get the mode from the ini, default is 2

	// Reading the tas
	var tas_path = ini_read_string("TAS", "path", "") // Get the path to the tas from the ini
	if file_exists(tas_path)
	{
		// Taken from https://www.reddit.com/r/gamemaker/comments/owann0/way_to_load_a_text_file_into_a_string_fast_in_gml/
		var file_buffer = buffer_load(tas_path);

		var tas_string = buffer_read(file_buffer, buffer_string);
		buffer_delete(file_buffer);
		
		// Now we will decode the TAS fom the string
		var split_string = string_split(tas_string, "\n") // Split the tas string at every line
		var splits = array_length_1d(split_string)

		for (var i=0; i<splits; i++)
		{
			var unconverted_inputs = string_split(split_string[i], ",") // Split the input string at every comma
			var inputs = array_length_1d(unconverted_inputs)

			// Now we will convert all inputs into keycodes
			var converted_inputs = []
			for (var b=0; b<inputs; b++)
			{	
				var digits = string_digits(unconverted_inputs[b])
				if digits != ""
				{
					converted_inputs[b] = real(digits)
				}
			}

			tas[i] = converted_inputs // Then we add the converted inputs to the tas
		}

		show_debug_message("Tas loaded")
		show_debug_message(concat("Frames: ", frames))
	}

	ini_close() // Close the ini to prevent a memory leak
}

/* BEGIN STEP */
frames = array_length_1d(tas) // update the frame count
if not global.tas_paused
{
	if mode == 1 // Recording
	{
		var recorded_inputs = [] // The recorded inputs for this frame

		// Loop through every keycode (from 8 to 249) to find the ones that are being pressed
		// Keycode table: http://www.foreui.com/articles/Key_Code_Table.htm
		for (var key=8; key<=249; key++)
		{
			if keyboard_check(key)
			{
				array_push(recorded_inputs, key)
			}
		}

		// After that, we will add the recorded inputs to the TAS
		tas[current_frame] = recorded_inputs

		frames = array_length_1d(tas) // update the frame count
	}
	else if mode == 2 // Playback
	{
		// Check if we arent at the end of the TAS yet
		if current_frame < frames
		{
			var current_inputs = tas[current_frame]
			var current_inputs_len = array_length_1d(current_inputs)

			// Pressing
			for (var i=0; i<current_inputs_len; i++)
			{
				var keycode = current_inputs[i]

				keyboard_key_press(keycode)
			}

			// Releasing
			// To check whether we need to release a key, we will get every previous key, and check if its in the current inputs
			if current_frame-1 >= 0 // Check if we are not at the start of the file
			{
				var previous_inputs = tas[current_frame-1]
				var previous_inputs_len = array_length_1d(previous_inputs)
				for (var p=0; p<previous_inputs_len; p++)
				{
					var prev_keycode = previous_inputs[p]
					var should_release = true

					for (var i=0; i<current_inputs_len; i++)
					{
						var current_keycode = current_inputs[i]
						if current_keycode == prev_keycode
						{
							should_release = false
							break
						}
					}

					if should_release {keyboard_key_release(prev_keycode)} // Release the key
				}
			}
		}
	}

	current_frame++ // advance the frame counter
}

// Frame advance
// If frame advanced is true and the game is paused, unpause the tas
if frame_advance == true and global.tas_paused == true 
{
	unpause_tas()
}
// Otherwise, if frame advance is true and the game isnt paused, then we pause the tas and toggle frame advance off
else if frame_advance == true and global.tas_paused == false
{
	pause_tas()
	frame_advance = false
}

// Keys
if keyboard_check_pressed(vk_f6) // Save tas
{
	var tas_name = "tas.ptm"
	if file_exists(tas_name)
	{
		file_delete(tas_name) // We delete the tas to avoid saving to the end of an existing one
	}

	var file = file_text_open_write(tas_name)

	// Loop through the tas to turn it into a string
	var tas_string = ""

	for (frame=0; frame<frames; frame++)
	{
		var input_string = ""
		var current_inputs = obj_tasplayback.tas[frame]
		var num_of_inputs = array_length_1d(current_inputs)

		for (var input=0; input<num_of_inputs; input++)
		{
			var keycode = current_inputs[input]
			input_string += concat(string(keycode), ",") // Add the keycode to the input string
		}

		show_debug_message(input_string)
		input_string += "\n"
		tas_string += input_string // Add the inputs to the tas string
	}

	// Save the tas to a file
	file_text_write_string(file, tas_string)
	file_text_close(file)
}
if keyboard_check_pressed(ord("P")) // Pause
{
	if global.tas_paused == false
	{
		// Pause
		global.tas_paused = true
		instance_deactivate_all(false)
		instance_activate_object(obj_tasplayback)
		instance_activate_object(obj_tastool)
	}
	else
	{
		global.tas_paused = false
		instance_activate_all()
	}
}
if keyboard_check_pressed(ord("F")) // Frame Advance
{
	frame_advance = true
}