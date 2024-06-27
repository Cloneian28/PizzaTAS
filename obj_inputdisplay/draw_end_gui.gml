if global.tas_show_inputs && instance_exists(obj_player)
{
	var draw_x = 8
	var draw_y = obj_screensizer.actual_height - 28

	var line_space = 20

	draw_set_halign(fa_left)
	draw_set_valign(fa_bottom)

	// Display input history
	var input_history_length = array_length_1d(input_history)
	for (var i = input_history_length; i > input_history_length-inputs_to_display; i--)
	{
		if i >= 0 && i < input_history_length
		{
			var inputs = input_history[i]
			var frames = inputs[0]
			var inputs = inputs[1]

			// draw inputs
			var num_of_inputs = string_length(inputs)

			draw_set_font(global.tasinputfont)
			for (var c = 1; c <= num_of_inputs; c++)
			{
				var input = string_char_at(inputs, c)

				if input == "D" {draw_x = 8}
				if input == "^" {draw_x = 8+16}
				if input == "v" {draw_x = 8+32}
				if input == "<" {draw_x = 8+48}
				if input == ">" {draw_x = 8+64}
				if input == "J" {draw_x = 8+80}
				if input == "G" {draw_x = 8+96}
				if input == "T" {draw_x = 8+112}

				draw_text(draw_x, draw_y, input)
			}

			// draw frames
			draw_set_font(global.smallfont)
			draw_text(144, draw_y + 16, frames) // we offset the y by 16 because the smallfont is taller than the input font
			draw_y -= line_space
		}
	}
}
