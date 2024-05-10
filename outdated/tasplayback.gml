tas_buffer = buffer_load("tas.pttas")
tas_string = buffer_read(tas_buffer, buffer_string)
buffer_delete(tas_buffer)
lines = string_split(tas_string, "\n")
frames = array_length_1d(lines)
inputs = array_create(frames, -4)
for (i = 0; i < frames; i++)
    inputs[i] = string_split(lines[i], ",")
current_frame = 0
max_inputs_displayed = 16
max_previous_inputs_displayed = 5
depth = -20000



if (current_frame > (frames - 1))
{
    instance_destroy()
    io_clear()
    return;
}
current_inputs = inputs[current_frame]
previous_inputs = inputs[clamp((current_frame - 1), 0, 9999999999999)]
curr_inputs_length = array_length_1d(current_inputs)
prev_inputs_length = array_length_1d(previous_inputs)
for (i = 0; i < prev_inputs_length; i++)
{
    if (previous_inputs[i] != "")
    {
        should_release = 1
        for (j = 0; j < (curr_inputs_length - 1); j++)
        {
            if (previous_inputs[i] == current_inputs[j])
                should_release = 0
        }
        if (should_release == 1)
        {
            keycode = real(previous_inputs[i])
            keyboard_key_release(keycode)
        }
    }
}
for (k = 0; k < (curr_inputs_length - 1); k++)
{
    if (current_inputs[k] != "")
    {
        keycode = real(current_inputs[k])
        keyboard_key_press(keycode)
    }
}
current_frame++



if (current_frame > (frames - 1))
    return;
draw_set_font(fnt_caption)
draw_set_color(c_white)
draw_set_halign(fa_left)
draw_set_valign(fa_bottom)
draw_x = string_width("A")
inputs_x = string_width("AAAAAAA")
draw_y = ((obj_screensizer.actual_height - 8) - (string_height("A") * max_inputs_displayed))
for (i = (-max_previous_inputs_displayed); i < max_inputs_displayed; i++)
{
    offset_y = (draw_y + (string_height("A") * i))
    offset_frame = clamp((current_frame + i), 0, 9999999999)
    if (offset_frame == current_frame)
        draw_set_color(c_white)
    else
        draw_set_color(c_gray)
    current_inputs = inputs[offset_frame]
    num_of_inputs = array_length_1d(current_inputs)
    draw_string = ""
    for (b = 0; b < (num_of_inputs - 1); b++)
    {
        input = current_inputs[b]
        if (input != "")
        {
            real_input = real(input)
            if (real_input == 16)
                draw_string += "shift"
            else if (real_input == 37)
                draw_string += "<"
            else if (real_input == 39)
                draw_string += ">"
            else if (real_input == 38)
                draw_string += "^"
            else if (real_input == 40)
                draw_string += "v"
            else
                draw_string += chr(real_input)
            draw_string += " "
        }
    }
    draw_text(draw_x, offset_y, string(offset_frame))
    draw_text(inputs_x, offset_y, draw_string)
}
