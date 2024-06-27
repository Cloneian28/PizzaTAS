// settings
global.tas_show_stats = true
global.tas_show_all_collision = true
global.tas_show_everything = false
global.tas_show_bounding_boxes = true
global.tas_unbound_camera = false

global.tas_paused = false

global.tas_show_inputs = true

// Tas keys
global.taskey_pause = ord("P")
global.taskey_frameadvance = ord("F")

global.taskey_savestate = vk_control
global.taskey_loadstate = vk_alt

global.taskey_save_tas = vk_f6

// Tas tool keys
global.taskey_toggle_unbound_camera = vk_f7
global.taskey_toggle_collision = vk_f1
global.taskey_toggle_stats = vk_f2
global.taskey_toggle_bounding_boxes = vk_f3
global.taskey_toggle_show_everything = vk_f4


// we add "-" and "_" to the smallfont
global.smallfont = font_add_sprite_ext(spr_smallerfont, "ABCDEFGHIJKLMNÑOPQRSTUVWXYZ!¡.:?¿1234567890ÁÄÃÀÂÉÈÊËÍÎÏÓÖÕÔÚÙÛÜÇ-_", 1, 0)

player_x = 0
player_y = 0
previous_x = 0
previous_y = 0
player_hsp = 0
player_vsp = 0
player_dx = 0 // difference between the previous x and the current x
player_dy = 0 // difference between the previous y and the current y

// acceleration
player_hdiff = 0 // difference between the current speed and the previous speed
player_vdiff = 0 // difference between the current speed and the previous speed
//estimated_max_speed = 0 //Estimated max speed based on current acceleration [UNUSED]

// mach speeds
mach1_maxspeed = 8; mach1_accel = 0.10;
mach2_maxspeed = 12; mach2_accel = 0.10;
mach3_maxspeed = 16; mach3_accel = 0.025;
mach4_maxspeed = 20; mach4_accel = 0.10;

depth = -10000000

// hit lag
hitlag = 0
prev_hitlag = 0

// room timer
room_time = 0.0
prev_room_time = 0.0
timer_step = 0.01666666666666667


// config
if file_exists("tasconfig.ini")
{
	var config = ini_open("tasconfig.ini")

	global.tas_show_stats = ini_read_real("TAS", "show_stats", true)
	global.tas_show_all_collision = ini_read_real("TAS", "show_all_collision", true)
	global.tas_show_everything = ini_read_real("TAS", "show_everything", false)
	global.tas_show_bounding_boxes = ini_read_real("TAS", "show_bounding_boxes", false)
	global.tas_unbound_camera = ini_read_real("TAS", "use_unbound_camera", false)

	// keys
	global.taskey_pause = ini_read_real("KEYS", "pause", ord("P"))
	global.taskey_frameadvance = ini_read_real("KEYS", "frame_advance", ord("F"))

	global.taskey_save_tas = ini_read_real("KEYS", "save_tas", vk_f6)

	global.taskey_toggle_unbound_camera = ini_read_real("KEYS", "toggle_unbound_camera", vk_f7)
	global.taskey_toggle_collision = ini_read_real("KEYS", "toggle_collision", vk_f1)
	global.taskey_toggle_stats = ini_read_real("KEYS", "toggle_stats", vk_f2)
	global.taskey_toggle_bounding_boxes = ini_read_real("KEYS", "toggle_bounding_boxes", vk_f3)
	global.taskey_toggle_show_everything = ini_read_real("KEYS", "toggle_show_everything", vk_f4)

	ini_close()
}
