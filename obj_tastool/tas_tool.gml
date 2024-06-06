/* create */
global.tas_show_stats = true
global.tas_show_all_collision = true
global.tas_show_everything = false
global.tas_show_bounding_boxes = true
global.tas_draw_object_stats = true

// we add "-" and "_" to the smallfont
global.smallfont = font_add_sprite_ext(spr_smallerfont, "ABCDEFGHIJKLMNÑOPQRSTUVWXYZ!¡.:?¿1234567890ÁÄÃÀÂÉÈÊËÍÎÏÓÖÕÔÚÙÛÜÇ-_", 1, 0)

player_x = 0
player_y = 0
previous_x = 0
previous_y = 0
player_hsp = 0
player_vsp = 0
player_dx = 0 // difference between the previous x and the current x
player_dy = 0 // difference between the previous y and the current y

// acceleration
player_hdiff = 0 // difference between the current speed and the previous speed
player_vdiff = 0 // difference between the current speed and the previous speed
//estimated_max_speed = 0 //Estimated max speed based on current acceleration [UNUSED]

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
	global.tas_show_all_collision = ini_read_real("TAS", "show_all_collision", true)
	global.tas_show_everything = ini_read_real("TAS", "show_everything", false)
	global.tas_show_bounding_boxes = ini_read_real("TAS", "show_bounding_boxes", false)

	ini_close()
}


/* end step */
if instance_exists(obj_player)
{
	// Player position
	player_x = obj_player.x
	player_y = obj_player.y

	// Player Velocity
	previous_hsp = player_hsp
	previous_vsp = player_vsp

	player_hsp = obj_player.hsp
	player_vsp = obj_player.vsp

	// Player position difference
	player_dx = player_x - previous_x
	player_dy = player_y - previous_y

	// Player acceleration (based on the difference between the previous hsp and the current hsp)
	player_hdiff = player_hsp - previous_hsp
	player_vdiff = player_vsp - previous_vsp


	// [UNUSED]
	// estimated_max_speed = abs(player_hsp) 
	// while (estimated_max_speed < 20)
	// {
	// 	estimated_accel = abs(player_accel)

	// 	// try to guess how much the acceleration would be at the current speed
	// 	if estimated_max_speed <= mach1_maxspeed      {estimated_accel = mach1_accel};
	// 	else if estimated_max_speed <= mach2_maxspeed {estimated_accel = mach2_accel};
	// 	else if estimated_max_speed <= mach3_maxspeed {estimated_accel = mach3_accel};
	// 	else if estimated_max_speed <= mach4_maxspeed {estimated_accel = mach4_accel};
	
	// 	estimated_max_speed += estimated_accel
	// 	if abs(player_accel) <= 0
	// 	{
	// 		break;
	// 	}
	// }
	// estimated_max_speed = estimated_max_speed * sign(player_hsp) // makes it negative if the player hsp is negative
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

// SHOW COLLISION
if instance_exists(obj_solid)
{
	if global.tas_show_all_collision
	{
		obj_solid.visible = true
		obj_solid.depth = -500
	}
}
if instance_exists(obj_slope)
{
	if global.tas_show_all_collision
	{
		obj_slope.visible = true
		obj_slope.depth = -500
	}
}
if instance_exists(obj_platform)
{
	if global.tas_show_all_collision
	{
		obj_platform.visible = true
		obj_platform.depth = -500
		with (obj_platform)
		{
			// check wheter the platform should be transparent or not
			var player_bbox_bottom = obj_player.bbox_bottom

			if y > player_bbox_bottom {image_alpha = 1}   // above
			if y < player_bbox_bottom {image_alpha = 0.3} // below
		}
	}
}

// enemy hitboxes
if instance_exists(obj_bosshitbox)
{
	if global.tas_show_all_collision
	{
		obj_bosshitbox.visible = true
		obj_bosshitbox.depth = -500
	}
}
if instance_exists(obj_hurtbox)
{
	if global.tas_show_all_collision
	{
		obj_hurtbox.visible = true
		obj_hurtbox.depth = -500
	}
	
}

// SHOW EVERYTHING
if global.tas_show_everything == true
{
	with (all)
	{
		visible = true // show absolutely everything
	}
}

/* draw gui end */
draw_set_font(global.smallfont) // NOTE: this font has no lowercase letters, so you must use string_upper() on any lowercase text
draw_set_halign(fa_left)
draw_set_valign(fa_top)

// draw the credits
credits_string = "TAS TOOL V0.0 BY CLONEIAN28"
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
	frame_string = concat(obj_tasplayback.current_frame, " ", obj_tasplayback.frames)

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

		sprite_string = concat("SPRITE: ", string_upper(sprite_get_name(obj_player.sprite_index)))
		draw_text(draw_x, draw_y, sprite_string) 

		draw_y += line_space

		state_string = concat("STATE: ", obj_player.state)
		draw_text(draw_x, draw_y, state_string) 
		

		/* - MISC STATS - */
		draw_y += line_space *2

		// Room info
		room_string = concat("ROOM: ", string_upper(room_get_name(room)))
		door_string = concat(" ", string_upper(obj_player.targetDoor))

		roominfo_string = concat(room_string, door_string)
		
		draw_text(draw_x, draw_y, roominfo_string) 

		draw_y += line_space
	}
}

/* draw end */
// collision drawing
if global.tas_show_all_collision
{
	// draw every object's collision mask
	with (all)
	{
		var collision_sprite = noone
		var parent_index = object_get_parent(object_index)

		var base_color = c_lime

		// get the sprite used for collision
		if sprite_exists(mask_index) 
		{
			if object_index != obj_heatafterimage
			{
				collision_sprite = mask_index
			}
		}

		if collision_sprite != noone
		{
			// apply special colors to certain objects
			if object_index == obj_player || parent_index == obj_player
			{
				base_color = c_blue
			}

			// get the 4 sides of the bounding box
			var bleft = sprite_get_bbox_left(collision_sprite) * image_xscale
			var btop = sprite_get_bbox_top(collision_sprite) * image_yscale
			var bright = sprite_get_bbox_right(collision_sprite) * image_xscale
			var bbottom = sprite_get_bbox_bottom(collision_sprite) * image_yscale

			// get the top left of the sprite (tl stands for top left)
			var tl_x = x - sprite_get_xoffset(collision_sprite) * image_xscale
			var tl_y = y - sprite_get_yoffset(collision_sprite) * image_yscale

			// get the 4 points of the mask in room coordinates
			var x1 = tl_x + bleft
			var y1 = tl_y + btop
			var x2 = tl_x + bright
			var y2 = tl_y + bbottom

			// draw the base of the mask
			if base_color != noone
			{
				draw_set_alpha(0.4)
				draw_set_color(base_color)
				draw_rectangle(x1, y1, x2, y2, false)
			}
		}
	}
}
// bounding box drawing
if global.tas_show_bounding_boxes
{
	with (all)
	{
		if object_index != obj_heatafterimage
		{
			var x1 = bbox_left
			var y1 = bbox_top
			var x2 = bbox_right
			var y2 = bbox_bottom

			draw_set_alpha(0.5)
			draw_set_color(c_white)
			draw_rectangle(x1, y1, x2, y2, true)
		}
	}
}
