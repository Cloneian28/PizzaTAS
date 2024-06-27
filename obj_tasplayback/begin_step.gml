function pause_tas()
{
	instance_deactivate_all(false)
	instance_activate_object(obj_tasplayback)
	instance_activate_object(obj_tastool)
	// Loop through every keycode (from 8 to 249) to find the ones that are being pressed
	// Keycode table: http://www.foreui.com/articles/Key_Code_Table.htm
	for (var key=8; key<=249; key++)
	{
		if keyboard_check(key)
		{
			// check if we should ignore the key
			var ignore = false
			for (var i=0; i<array_length_1d(ignore_keys); i++)
			{
				if ignore_keys[i] == key
				{
					ignore = true
				}
			}

			if not ignore
			{
				array_push(keys_when_paused, key)
			}
		}
	}
	global.tas_paused = true
	
}
function unpause_tas()
{
	instance_activate_all()
	// Loop through every keycode (from 8 to 249) to find the ones that are being pressed
	// Keycode table: http://www.foreui.com/articles/Key_Code_Table.htm
	for (var key=8; key<=249; key++)
	{
		if keyboard_check(key)
		{
			// check if we should ignore the key
			var ignore = false
			for (var i=0; i<array_length_1d(ignore_keys); i++)
			{
				if ignore_keys[i] == key
				{
					ignore = true
				}
			}

			if not ignore
			{
				// Check if the key is in the pause keys
				var in_pause_keys = false
				for (var j=0; j<array_length_1d(keys_when_paused); j++)
				{
					var paused_key = keys_when_paused[j]

					if paused_key == key
					{
						in_pause_keys = true
					}
				}

				if not in_pause_keys
				{
					// Repress
					keyboard_key_release(key)
					keyboard_key_press(key)
				}
			}
		}
	}
	global.tas_paused = false

	keys_when_paused = []
	
}

// Keys
if keyboard_check_pressed(global.taskey_save_tas) // Save tas
{	
	var tas_name = ""
	if tas_path != ""
	{
		tas_name = tas_path
	}
	else
	{
		tas_name = "tas.ptm"
	}
	if file_exists(tas_name)
	{
		// We delete the tas to avoid saving to the end of an existing one
		file_delete(tas_name) 
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
			input_string += concat(string(keycode), ",")
		}

		show_debug_message(input_string)
		
		input_string += "\n"
		tas_string += input_string
	}

	// Save the tas to a file
	file_text_write_string(file, tas_string)
	file_text_close(file)
}


// Tas stuff
frames = array_length_1d(tas) // update the frame count
if not global.tas_paused
{
	if mode == 1 // Recording
	{
		var recorded_inputs = []

		// Loop through every keycode (from 8 to 249) to find the ones that are being pressed
		// Keycode table: http://www.foreui.com/articles/Key_Code_Table.htm
		for (var key=8; key<=249; key++)
		{
			if keyboard_check(key)
			{
				// check if we should ignore the key
				var ignore = false
				for (var i=0; i<array_length_1d(ignore_keys); i++)
				{
					if ignore_keys[i] == key
					{
						ignore = true
					}
				}

				if not ignore
				{
					array_push(recorded_inputs, key)
				}
			}
		}

		tas[current_frame] = recorded_inputs
		show_debug_message(concat(current_frame, " ", recorded_inputs))

		frames = array_length_1d(tas)
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

	current_frame++
}