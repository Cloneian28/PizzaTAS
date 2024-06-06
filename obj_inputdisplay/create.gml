input_history = []
current_inputs = ""
frames_without_change = 0
inputs_to_display = 10

global.tasinputfont = font_add_sprite_ext(spr_tasinputfont, "^v<>JGTD", 1, 0)
global.tas_show_inputs = true

if file_exists("tasconfig.ini")
{
	var config = ini_open("tasconfig.ini")

	global.tas_show_inputs = ini_read_string("TAS", "show_inputs", true)
	inputs_to_display = ini_read_string("TAS", "inputs_to_display", 10)

	ini_close()
}
