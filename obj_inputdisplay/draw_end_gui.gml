if global.tas_show_inputs && instance_exists(obj_player)
{
	var draw_x = 8
	var draw_y = obj_screensizer.actual_height - 28

	var line_space = 20

	draw_set_halign(fa_left)
	draw_set_valign(fa_bottom)

	// Display current inputs
	draw_set_font(global.smallfont)
	draw_text(draw_x, draw_y + 16, frames_without_change) // we offset the y by 16 so that its next to the inputs

	var separation = max(string_width("AA "), string_width(string(frames_without_change)+" "))

	draw_set_font(global.tasinputfont)
	draw_text(draw_x+separation, draw_y, current_inputs)

	// Display input history
	var input_history_length = array_length_1d(input_history)
	for (var i = input_history_length; i > input_history_length-inputs_to_display; i--)
	{
		if i >= 0 && i < input_history_length
		{
			draw_y -= line_space

			var old_inputs = input_history[i]
			var frames = old_inputs[0]
			var inputs = old_inputs[1]

			draw_set_font(global.smallfont)
			draw_text(draw_x, draw_y + 16, frames)

			var separation = max(string_width("AA "), string_width(string(frames)+" "))

			draw_set_font(global.tasinputfont)
			draw_text(draw_x+separation, draw_y, inputs)
		}
	}
}