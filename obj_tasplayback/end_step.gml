if keyboard_check_pressed(global.taskey_pause) // Pausing
{
	if global.tas_paused == false
	{
		pause_tas()
	}
	else
	{
		unpause_tas()
	}
}
if keyboard_check_pressed(global.taskey_frameadvance)
{
	frame_advance = true
}

if frame_advance == true
{
	if global.tas_paused
	{
		unpause_tas()
	}
	else
	{
		frame_advance = false
		pause_tas()
	}
}


