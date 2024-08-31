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

	// Player speed
	player_movespeed = obj_player.movespeed


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

	// Hit lag
	prev_hitlag = hitlag
	hitlag = obj_player.hitLag
}

previous_x = player_x
previous_y = player_y


if global.tas_show_all_collision
{
	// SHOW COLLISION
	if instance_exists(obj_solid)
	{
		obj_solid.visible = true
		obj_solid.depth = -500
	}
	if instance_exists(obj_slope)
	{
		obj_slope.visible = true
		obj_slope.depth = -500
	}
	if instance_exists(obj_platform)
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

	// enemy hitboxes
	if instance_exists(obj_bosshitbox)
	{
		obj_bosshitbox.visible = true
		obj_bosshitbox.depth = -500
	}
	if instance_exists(obj_hurtbox)
	{
		obj_hurtbox.visible = true
		obj_hurtbox.depth = -500
	}
}

if instance_exists(obj_hallway)
{
	obj_hallway.visible = global.tas_show_all_collision
	obj_hallway.depth = -500
}
if instance_exists(obj_verticalhallway)
{
	obj_verticalhallway.visible = global.tas_show_all_collision
	obj_verticalhallway.depth = -500
}


// SHOW EVERYTHING
if global.tas_show_everything == true
{
	with (all)
	{
		visible = true // show absolutely everything
	}
}

// KEYS
if keyboard_check_pressed(global.taskey_toggle_unbound_camera)
{
	global.tas_unbound_camera = !global.tas_unbound_camera
}
if keyboard_check_pressed(global.taskey_toggle_collision)
{
	global.tas_show_all_collision = !global.tas_show_all_collision
}
if keyboard_check_pressed(global.taskey_toggle_stats)
{
	global.tas_show_stats = !global.tas_show_stats
}
if keyboard_check_pressed(global.taskey_toggle_bounding_boxes)
{
	global.tas_show_bounding_boxes = !global.tas_show_bounding_boxes
}
if keyboard_check_pressed(global.taskey_toggle_show_everything)
{
	global.tas_show_everything = !global.tas_show_everything
}
if keyboard_check_pressed(global.taskey_add_watch)
{
    var label = get_string("Enter the name for the watch (this can be whatever you want)", "")
    if (label != "")
    {
        var object = get_string("Enter the name of the object (type 'global' for a global variable)", "")
        if (object != "")
        {
            var variable = get_string("Enter the variable to watch (ej: railmovespeed)", "")
            if (variable != "")
            {
                var watch = concat(label, ",", object, ",", variable)
                if (watches == "")
                    watches += watch
                else
                    watches += (";" + watch)
                var config = ini_open("tasconfig.ini")
                ini_write_string("TAS", "watches", watches)
            }
        }
    }
}

if global.tas_unbound_camera
{
	var cam_width = camera_get_view_width(view_camera[0])
    var cam_height = camera_get_view_height(view_camera[0])

    var cam_x = player_x - (cam_width/2)
    var cam_y = player_y - (cam_height/2)

	camera_set_view_pos(view_camera[0], cam_x, cam_y)
}

if not global.tas_paused
{
	room_time += timer_step
}
// Transition Time
if instance_exists(obj_fadeout)
{
    if (transition_time == 0 && (!obj_fadeout.fadein))
    {
        transition_time = room_time
    }
}