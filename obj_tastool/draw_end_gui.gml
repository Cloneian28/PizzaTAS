draw_set_font(global.smallfont) // NOTE: this font has no lowercase letters, so you must use string_upper() on any lowercase text
draw_set_halign(fa_left)
draw_set_valign(fa_top)

// draw the credits
credits_string = "TAS TOOL V1.0 BY CLONEIAN28"
draw_text(8, 8, credits_string)

line_space = string_height("A")


// Tas info
if obj_tasplayback.mode != 0
{
	draw_x = string_width(credits_string+"AA")
	draw_y = 8
	
	// Get the mode the tas is in
	mode_string = ""
	if obj_tasplayback.mode == 1 	  {mode_string = "RECORDING"}
	else if obj_tasplayback.mode == 2 {mode_string = "PLAYING"}

	// Get the current frame and the amount of frames left in the tas
	frame_string = concat(obj_tasplayback.current_frame)

	draw_text(draw_x, draw_y, concat(mode_string, " ", frame_string))
} 

// player stats
if instance_exists(obj_player)
{
	draw_x = 8
	draw_y = 12+line_space // just below the credits


	if global.tas_show_stats
	{
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
		
		// Speed Difference
		hdiff_string = concat("HDIF: ", player_hdiff)
		vdiff_string = concat("VDIF: ", player_vdiff)

		draw_text(draw_x, draw_y, hdiff_string)
		draw_text(draw_x+separation, draw_y, vdiff_string)

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
		draw_y = 8

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
