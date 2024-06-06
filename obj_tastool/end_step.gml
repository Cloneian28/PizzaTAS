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

// Loop through every keycode (from 8 to 249) to find the keys that are being pressed
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
