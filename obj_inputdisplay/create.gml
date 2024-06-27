input_history = [[0, ""]]
inputs_to_display = 15

global.tasinputfont = font_add_sprite_ext(spr_tasinputfont, "^v<>JGTD", 1, 0)

if file_exists("tasconfig.ini")
{
	var config = ini_open("tasconfig.ini")

	global.tas_show_inputs = ini_read_string("TAS", "show_inputs", true)
	inputs_to_display = ini_read_string("TAS", "inputs_to_display", 15)

	ini_close()
}
