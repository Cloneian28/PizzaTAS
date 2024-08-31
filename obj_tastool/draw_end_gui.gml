draw_set_font(global.smallfont) // NOTE: this font has no lowercase letters, so you must use string_upper() on any lowercase text
draw_set_halign(fa_left)
draw_set_valign(fa_top)

// draw the credits
credits_string = "TAS TOOL V1.4l BY CLONEIAN28"
draw_text(8, 8, credits_string)

line_space = string_height("A")


// Tas info
draw_x = string_width(credits_string+"AA")
draw_y = 8
	
// Get the mode the tas is in
mode_string = ""
if global.tas_paused == true      {mode_string = "PAUSED"}
else if obj_tasplayback.mode == 1 {mode_string = "RECORDING"}
else if obj_tasplayback.mode == 2 {mode_string = "PLAYING"}

// Get the current frame and the amount of frames left in the tas
if mode_string != ""
{
	if obj_tasplayback.mode
	{
		mode_string = concat(mode_string, " ", obj_tasplayback.current_frame)
	}

	draw_text(draw_x, draw_y, mode_string)
}



// player stats
if instance_exists(obj_screensizer)
{
	if global.tas_show_stats
	{
		if instance_exists(obj_player)
		{
			draw_x = 8
			draw_y = 12+line_space // just below the credits
		
			/* - PLAYER STATS - */
			// Position
			separation = string_width("AAAAAAAAAA ")

			x_string = concat("X: ", player_x)//; if player_x < 0 {x_string = concat("X:M", player_x)}
			y_string = concat("Y: ", player_y)//; if player_y < 0 {y_string = concat("Y:M", player_y)}
			dx_string = concat("DX: ", player_dx)//; if player_dx < 0 {dx_string = concat("DX:M", player_dx)}
			dy_string = concat("DY: ", player_dy)//; if player_dy < 0 {dy_string = concat("DY:M", player_dy)}

			draw_text(draw_x, draw_y, x_string)
			draw_text(draw_x+separation, draw_y, y_string)

			draw_y += line_space

			draw_text(draw_x, draw_y, dx_string)
			draw_text(draw_x+separation, draw_y, dy_string)

			draw_y += line_space


			// Speed
			hsp_string = concat("HSP: ", player_hsp)//; if player_hsp < 0 {hsp_string = concat("HSP:M", player_hsp)}
			vsp_string = concat("VSP: ", player_vsp)//; if player_vsp < 0 {vsp_string = concat("VSP:M", player_vsp)}

			draw_text(draw_x, draw_y, hsp_string)
			draw_text(draw_x+separation, draw_y, vsp_string)

			draw_y += line_space
			
			// Speed
			movespeed_string = concat("SPEED: ", player_movespeed)

			draw_text(draw_x, draw_y, movespeed_string)

			draw_y += line_space*2


			// State info
			separation = string_width("AAAAAAAAAA ")

			jump_string = concat("JUMP: ", obj_player.can_jump)
			if obj_player.coyote_time != 7 && obj_player.coyote_time > 0
			{
				jump_string += concat(" ", obj_player.coyote_time)
			}
			grounded_string = concat("GROUNDED: ", obj_player.grounded)

			draw_text(draw_x, draw_y, jump_string) 
			draw_text(draw_x+separation, draw_y, grounded_string)
			
			draw_y += line_space

			sprite_string = concat("SPRITE: ", string_upper(sprite_get_name(obj_player.sprite_index)), " ", obj_player.image_index)
			draw_text(draw_x, draw_y, sprite_string) 

			draw_y += line_space

			state_string = concat("STATE: ", obj_player.state)
			draw_text(draw_x, draw_y, state_string) 
			

			/* - MISC STATS - */
			draw_x = obj_screensizer.actual_width-8
			draw_y = 8 // below room info

			// Room info
			room_string = concat(string_upper(room_get_name(room)))
			door_string = concat(" ", string_upper(obj_player.targetDoor))

			roominfo_string = concat(room_string, door_string)
			
			draw_set_halign(fa_right)
			draw_set_valign(fa_top)
			draw_text(draw_x, draw_y, roominfo_string)

			// Hit lag
			if hitlag != prev_hitlag
			{
				draw_y += line_space
				hitlag_string = concat("LAG: ", hitlag)

				draw_text(draw_x, draw_y, hitlag_string)
			}

			
		}
	}
	if global.tas_show_watches
    {
        draw_set_halign(fa_right)
        draw_set_valign(fa_top)

        draw_x = obj_screensizer.actual_width - 8
        draw_y += (line_space * 2)

        var watch_array = string_split(watches, ";")
        var num_of_watches = array_length_1d(watch_array)

        // Parse the watches
        for (var i = 0; i < num_of_watches; i++)
        {
            if (watch_array[i] != "")
            {
                var watch = string_split(watch_array[i], ",")
                var label = string_upper(watch[0])

                var variable = watch[2]
                var variable_value = "???"

                if (watch[1] != "global")
                {
                    var object = asset_get_index(watch[1])
                    if object_exists(object)
                    {
                        var already_checked = false
                        with (object)
                        {
                            if (already_checked == false)
                            {
                                variable_value = "???"
                                if variable_instance_exists(self, variable)
                                {
                                    variable_value = variable_instance_get(self, variable)
                                }
                                already_checked = true
                            }
                        }
                    }
                }
                else
                {
                    if variable_global_exists(variable)
                    {
                        variable_value = variable_global_get(variable)
                    }
                    already_checked = true
                }

                // Draw the watch
                draw_text(draw_x, draw_y, concat(label, ": ", variable_value))
                draw_y += line_space
            }
        }
    }

	// Room Timer
	if global.option_timer
	{
		// code taken from: https://forum.gamemaker.io/index.php?threads/time-function-stop-watch.54637/
		var room_minutes = room_time div 60;
		var room_seconds = (room_time mod (60*60)) mod (60);

		var prev_room_minutes = prev_room_time div 60;
		var prev_room_seconds = (prev_room_time mod (60*60)) mod (60);

		var room_timer_string = scr_get_timer_string(room_minutes, room_seconds, 0)
		var prev_room_timer_string = scr_get_timer_string(prev_room_minutes, prev_room_seconds, 0)

		draw_x = obj_screensizer.actual_width - 115
		draw_y = obj_screensizer.actual_height - 8 - line_space

		if global.option_timer_type == 2
		{
			draw_y -= line_space
		}


		draw_set_halign(fa_left)
		draw_set_valign(fa_bottom)
		draw_text(draw_x, draw_y, room_timer_string)
		draw_text(draw_x, draw_y-line_space, prev_room_timer_string)
		if (transition_time > 0)
        {
            draw_set_color(c_lime)
            draw_text(draw_x, (draw_y - line_space * 2), transition_time_string)
        }
	}
}
