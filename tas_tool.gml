/* create */
global.tas_show_stats = true
global.tas_show_inputs = false

player_x = 0
player_y = 0
previous_x = 0
previous_y = 0
player_hsp = 0
player_vsp = 0
player_dx = 0 // difference between the previous x and the current x
player_dy = 0 // difference between the previous y and the current y

// acceleration
player_accel = 0 // Current Acceleration (based on the difference between the current speed and the previous speed)
estimated_max_speed = 0 // Estimated max speed based on current_acceleration

// mach speeds
mach1_maxspeed = 8; mach1_accel = 0.10;
mach2_maxspeed = 12; mach2_accel = 0.10;
mach3_maxspeed = 16; mach3_accel = 0.025;
mach4_maxspeed = 20; mach4_accel = 0.10;

depth = -10000000

// input display
inputs = []
frames_without_change = 0
inputs_to_draw = 10

// config
if file_exists("tasconfig.ini")
{
	var config = ini_open("tasconfig.ini")

	global.tas_show_stats = ini_read_real("TAS", "show_stats", true)
	global.tas_show_inputs = ini_read_real("TAS", "show_input_display", true)
	inputs_to_draw = ini_read_real("TAS", "inputs_to_draw", 10)

	ini_close()
}


/* end step */
if instance_exists(obj_player)
{
	player_x = obj_player.x
	player_y = obj_player.y

	previous_hsp = player_hsp
	previous_vsp = player_vsp

	player_hsp = obj_player.hsp
	player_vsp = obj_player.vsp
	player_dx = player_x - previous_x
	player_dy = player_y - previous_y

	// Player acceleration
	player_accel = player_hsp - previous_hsp


	estimated_max_speed = abs(player_hsp) 
	while (estimated_max_speed < 20)
	{
		estimated_accel = abs(player_accel)
		// try to guess how much the acceleration would be at the current speed
		if estimated_max_speed <= mach1_maxspeed      {estimated_accel = mach1_accel};
		else if estimated_max_speed <= mach2_maxspeed {estimated_accel = mach2_accel};
		else if estimated_max_speed <= mach3_maxspeed {estimated_accel = mach3_accel};
		else if estimated_max_speed <= mach4_maxspeed {estimated_accel = mach4_accel};

		estimated_max_speed += estimated_accel
		if abs(player_accel) <= 0
		{
			break;
		}
	}
	estimated_max_speed = estimated_max_speed * sign(player_hsp) // makes it negative if the player hsp is negative
}

previous_x = player_x
previous_y = player_y

// Input display
var current_inputs = []

// Loop through every keycode (from 8 to 249) to find the ones that are being pressed
// Keycode table: http://www.foreui.com/articles/Key_Code_Table.htm
for (var key=8; key<=249; key++)
{
	if keyboard_check(key)
	{
		array_push(current_inputs, key)
	}
}

array_push(inputs, current_inputs)

/* draw end gui */
draw_set_font(global.smallfont)
draw_set_halign(fa_left)
draw_set_valign(fa_top)

// draw the credits
credits_string = "TAS TOOL V0.0 BY CLONEIAN28\n"
draw_text(12, 8, credits_string)

// draw everything else
draw_x = string_width("A")
draw_y = 12 // just below the credits

if instance_exists(obj_player)
{
	line_space = string_height("A") // the amount of space to go down whenever we want to make a new line

	draw_y += line_space // next line

	if global.tas_show_stats
	{
		// Position
		separation = string_width("A: AAAAAAAA ") // accounts for a short label and 8 digits

		x_string = concat("X: ", player_x); if player_x < 0 {x_string = concat("X:M", player_x)}
		y_string = concat("Y: ", player_y); if player_y < 0 {y_string = concat("Y:M", player_y)}
		dx_string = concat("DX: ", player_dx); if player_dx < 0 {dx_string = concat("DX:M", player_dx)}
		dy_string = concat("DY: ", player_dy); if player_dy < 0 {dy_string = concat("DY:M", player_dy)}

		draw_text(draw_x, draw_y, x_string) // draw x position
		draw_text(draw_x+separation, draw_y, y_string) // draw y position with separation

		draw_y += line_space // next line

		draw_text(draw_x, draw_y, dx_string) // draw dx position
		draw_text(draw_x+separation, draw_y, dy_string) // draw dy position with separation

		draw_y += line_space // next line

		// Speed
		hsp_string = concat("HSP: ", player_hsp); if player_hsp < 0 {hsp_string = concat("HSP:M", player_hsp)}
		vsp_string = concat("VSP: ", player_vsp); if player_vsp < 0 {vsp_string = concat("VSP:M", player_vsp)}

		draw_text(draw_x, draw_y, hsp_string) // draw hsp
		draw_text(draw_x+separation, draw_y, vsp_string) // draw vsp with separation

		draw_y += line_space // next line

		// Acceleration
		accel_string = concat("ACCEL: ", player_accel); if player_accel < 0 {accel_string = concat("ACCEL:M", player_accel)}
		est_max_string = concat("EST MAX: ", estimated_max_speed); if estimated_max_speed < 0 {est_max_string = concat("EST MAX:M", estimated_max_speed)}

		draw_text(draw_x, draw_y, accel_string) // draw accel
		draw_text(draw_x+separation, draw_y, est_max_string) // draw estimated maximum speed with separation

		draw_y += line_space *2 // skip 2 lines
	}
}



