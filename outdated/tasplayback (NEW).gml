/* create */
global.tas_mode = 0 // modes: 0 = no tas, 1: recording, 2: playback
global.tas_path = ""
global.tas_inputs = ""
global.tas_current_frame = 0
global.inputs_initialized = false

title_screen_passed = false // HACK: see begin step

player_index = 0 // HACK: prevents a crash having to do with getinput

scr_initinput()

// HACK: we define these to avoid a crash
key_up = 0
key_up2 = 0
key_right = 0
key_right2 = 0
key_left = 0
key_left2 = 0
key_down = 0
key_down2 = 0
key_jump = 0
key_jump2 = 0
key_jump3 = 0 
key_slap = 0
key_slap2 = 0
key_taunt = 0
key_taunt2 = 0
key_attack = 0
key_attack2 = 0
key_shoot = 0
key_shoot2 = 0
key_start = 0
key_start2 = 0
key_quit = 0
key_quit2 = 0
key_escape = 0
key_chainsaw = 0
key_chainsaw2 = 0
key_groundpound = 0
key_groundpound2 = 0
key_superjump = 0
key_superjump2 = 0
stickpressed = 0
stickpressed_horizontal = 0
stickpressed_vertical = 0


if file_exists("tasconfig.ini")
{
	config = ini_open("tasconfig.ini")
	global.tas_path = ini_read_string("TAS", "path", "")
	global.tas_mode = ini_read_real("TAS", "mode", 2) // playback by default
	ini_close()

	if file_exists(global.tas_path)
	{
		// taken from https://www.reddit.com/r/gamemaker/comments/owann0/way_to_load_a_text_file_into_a_string_fast_in_gml/
		var file_buffer = buffer_load(global.tas_path);
		global.tas_inputs = buffer_read(file_buffer, buffer_string);
		buffer_delete(file_buffer);
	}
}
else
{
	ini_open("tasconfig.ini")
	ini_write_string("TAS", "path", "")
	ini_write_real("TAS", "mode", 0)
	ini_close()
}

/* begin step */
if global.tas_mode == 1 // recording
{
	// Regular Inputs
	scr_getinput()
	inputs = ""

	// check every input variable and add it to inputs
	if key_up == 1 {inputs += "up "} 
    if key_right == 1 {inputs += "right "}
    if key_left == 1 {inputs += "left "}
    if key_down == 1 {inputs += "down "}
    if key_jump2 == 1 {inputs += "jump "} // 2 is for held
    if key_taunt == 1 {inputs += "taunt "}
    if key_attack == 1 {inputs += "grab "} 
    if key_start2 == 1 {inputs += "start "} // 2 is for held
    if key_groundpound == 1 {inputs += "groundpound "}
    if key_superjump == 1 {inputs += "superjump "}

    // Menu inputs
	// for simplicity sake we make the menu actions be the same as the regular actions
    /* scr_menu_getinput()
	if key_up == 1 {inputs += "up "}
    if key_right == 1 {inputs += "right "}
    if key_left == 1 {inputs += "left "}
    if key_down == 1 {inputs += "down "}
    if key_jump2 == 1 {inputs += "jump "}
    if key_start2 == 1 {inputs += "start "}
    if key_back == 1 {inputs += "grab "} 
    if key_delete == 1 {inputs += "taunt "} */

    inputs += "\n"
	
	show_debug_message(inputs)
	global.tas_inputs += inputs

	if keyboard_check(vk_control) && keyboard_check_pressed(ord("S"))
	{
		save_path = get_string("Enter the name of the tas", "tas")+".ptm"
		file = file_text_open_write(save_path)
		file_text_write_string(file, global.tas_inputs)
		file_text_close(file)

		global.tas_mode = 0
	}
}
else if global.tas_mode == 2
{
	split_inputs = string_split(global.tas_inputs, "\n") // split the inputs into multiple lines

	previous_inputs = string_split(split_inputs[clamp(global.tas_current_frame-1, 0, 9999999999)], " ") // get the previous inputs from the split inputs and split them at every space
	previous_inputs_len = array_length_1d(previous_inputs)

	current_inputs = string_split(split_inputs[global.tas_current_frame], " ") // get the current inputs from the split inputs and split them at every space

	show_debug_message(current_inputs)

	current_inputs_len = array_length_1d(current_inputs)
	

	// reset all inputs
	key_up = 0
	key_up2 = 0
	key_right = 0
	key_right2 = 0
	key_left = 0
	key_left2 = 0
	key_down = 0
	key_down2 = 0
	key_jump = 0
	key_jump2 = 0
	key_jump3 = 0 
	key_slap = 0
	key_slap2 = 0
	key_taunt = 0
	key_taunt2 = 0
	key_attack = 0
	key_attack2 = 0
	key_shoot = 0
	key_shoot2 = 0
	key_start = 0
	key_quit = 0
	key_quit2 = 0
	key_escape = 0
	key_chainsaw = 0
	key_chainsaw2 = 0
	key_groundpound = 0
	key_groundpound2 = 0
	key_superjump = 0
	key_superjump2 = 0
	stickpressed = 0
	stickpressed_horizontal = 0
	stickpressed_vertical = 0


	// check inputs
	for (i=0; i<current_inputs_len-1; i++)
	{
		current_input = current_inputs[i]
		just_pressed = true

		
		
		// check just pressed
		// loop through every input in previous input to see if our current input is in there
		for (b=0; b<previous_inputs_len-1; b++)
		{
			previous_input = previous_inputs[b]
			if current_input == previous_input
			{
				just_pressed = false
			}
		}

		

		// press inputs (what the 2 means in each one is inconsistent)
		if current_input == "jump"   {key_jump    = just_pressed; key_jump2   = true} // 2 is for held
		if current_input == "attack" {key_attack2 = just_pressed; key_attack  = true} // 2 is for pressed
		if current_input == "taunt"  {key_taunt2  = just_pressed; key_taunt   = true} // 2 is for pressed
		if current_input == "up"     {key_up2     = just_pressed; key_up      = true} // 2 is for pressed
		if current_input == "down"   {key_down2   = just_pressed; key_down    = true} // 2 is for pressed
		if current_input == "left"   {key_left2   = just_pressed; key_left    = true} // 2 is for pressed
		if current_input == "right"  {key_right2  = just_pressed; key_right   = true} // 2 is for pressed
		if current_input == "start"  {key_start   = just_pressed; key_start2  = true} // 2 is for held
		if current_input == "quit"   {key_quit2   = just_pressed; key_quit    = true} // 2 is for pressed
		if current_input == "groundpound" {key_groundpound = just_pressed; key_groundpound2 = true}
		if current_input == "superjump"   {key_superjump   = just_pressed; key_superjump2   = true}

		// HACK: The title screen doesnt use getinput (for the lights turning on at least), so we use this to prevent a softlock
		if room == Mainmenu{
			if current_input != "" && title_screen_passed == false 
			{
				keyboard_key_press(vk_enter); title_screen_passed = true
			}
		}
	}

	

	// check released (only jump has this check so thats the only one we are checking)
	for (i=0; i<previous_inputs_len-1; i++)
	{
		input = previous_inputs[i]
		if input == "jump"
		{
			// check every current input to see if jump is in there
			just_released = true
			for (b=0; b<current_inputs_len-1; b++)
			{
				current_input = current_inputs[b]
				if current_input == "jump"
				{
					just_released = false
				}
			}

			key_jump3 = just_released
		}
	}
} 

global.tas_current_frame += 1



/* Draw End GUI */
frames = array_length_1d(global.tas_inputs)
if global.tas_current_frame < frames
{
	current_inputs = global.tas_inputs[global.tas_current_frame]
	draw_set_halign(fa_left)
	draw_set_valign(fa_bottom)
	draw_text(24, obj_screensizer.actual_height-24, current_inputs)
}
