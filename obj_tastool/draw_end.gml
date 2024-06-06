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
