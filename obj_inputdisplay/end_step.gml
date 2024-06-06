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

	if inputs == current_inputs
	{
		frames_without_change += 1
	}
	else
	{
		old_inputs = [frames_without_change, current_inputs]
		array_push(input_history, old_inputs)

		frames_without_change = 1
		current_inputs = inputs
	}
}