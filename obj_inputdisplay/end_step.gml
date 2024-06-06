if global.tas_show_inputs && instance_exists(obj_player)
{
	var inputs = ""

	if obj_player.key_attack   {inputs += "D"} // Dash (for some ungodly reason)

	if obj_player.key_up       {inputs += "^"} // Up
	if obj_player.key_down     {inputs += "v"} // Down
	if abs(obj_player.key_left){inputs += "<"} // Left
	if obj_player.key_right    {inputs += ">"} // Right

	if obj_player.key_jump2    {inputs += "J"} // Jump
	if obj_player.key_slap     {inputs += "G"} // Grab
	if obj_player.key_taunt    {inputs += "T"} // Taunt

	var input_history_length = array_length_1d(input_history)
	if inputs == input_history[input_history_length-1][1]
	{
		input_history[input_history_length-1][0] += 1
	}
	else
	{
		new_inputs = [1, inputs]
		array_push(input_history, new_inputs)
	}

	while input_history_length > inputs_to_display
	{
		array_delete(input_history, 0, 1) // delete the first element of the array until the array is at the desired size
		input_history_length = array_length_1d(input_history)
	}
}