; For use with versions of UndertaleModTool that do not support structs
: This script is a modified version of scr_pause which makes sure obj_tastool and obj_tasplayback are active at all times
; If you are using UndertaleModTool Community Edition, and want to modify this script, you can just modify the script directly in UMT to save yourself the headache of dealing with assembly

.localvar 2 arguments
.localvar 2747 icon 2032
.localvar 27 i 2050
.localvar 2787 obj 2058
.localvar 254 p 2062
.localvar 80 q 2063
.localvar 66 b 2069
.localvar 1073 destroy 2070
.localvar 256 a 2071

:[0]
b [2]

> gml_Script_scr_pauseicon_draw (locals=1, argc=3)
:[1]
pushi.e -1
push.v arg.argument0
conv.v.i
push.v [array]self.pause_icons
pop.v.v local.icon
pushloc.v local.icon
pushi.e -9
push.v [stacktop]self.image_alpha
push.i 16777215
conv.i.v
pushi.e 0
conv.i.v
pushi.e 1
conv.i.v
pushi.e 1
conv.i.v
push.v arg.argument2
pushloc.v local.icon
pushi.e -9
push.v [stacktop]self.sprite_yoffset
add.v.v
pushloc.v local.icon
pushi.e -9
push.v [stacktop]self.shake_y
add.v.v
push.v arg.argument1
pushloc.v local.icon
pushi.e -9
push.v [stacktop]self.sprite_xoffset
add.v.v
pushloc.v local.icon
pushi.e -9
push.v [stacktop]self.shake_x
add.v.v
pushloc.v local.icon
pushi.e -9
push.v [stacktop]self.image_index
pushloc.v local.icon
pushi.e -9
push.v [stacktop]self.sprite_index
call.i draw_sprite_ext(argc=9)
popz.v
exit.i

:[2]
push.i gml_Script_scr_pauseicon_draw
conv.i.v
pushi.e -1
conv.i.v
call.i method(argc=2)
dup.v 0
pushi.e -6
pop.v.v [stacktop]self.scr_pauseicon_draw
popz.v
b [4]

> gml_Script_scr_create_pause_image (locals=0, argc=0)
:[3]
pushi.e 1
conv.i.v
call.i draw_set_alpha(argc=1)
popz.v
pushi.e 0
conv.i.v
pushi.e 0
conv.i.v
pushi.e 0
conv.b.v
pushi.e 0
conv.b.v
pushbltn.v builtin.application_surface
call.i surface_get_height(argc=1)
pushbltn.v builtin.application_surface
call.i surface_get_width(argc=1)
pushi.e 0
conv.i.v
pushi.e 0
conv.i.v
pushbltn.v builtin.application_surface
call.i sprite_create_from_surface(argc=9)
pop.v.v self.screensprite
pushi.e 0
conv.i.v
pushi.e 0
conv.i.v
pushi.e 0
conv.b.v
pushi.e 0
conv.b.v
push.v 291.gui_surf
call.i surface_get_height(argc=1)
push.v 291.gui_surf
call.i surface_get_width(argc=1)
pushi.e 0
conv.i.v
pushi.e 0
conv.i.v
push.v 291.gui_surf
call.i sprite_create_from_surface(argc=9)
pop.v.v self.guisprite
push.v 291.actual_height
pushbltn.v builtin.application_surface
call.i surface_get_height(argc=1)
div.v.v
push.v 291.actual_width
pushbltn.v builtin.application_surface
call.i surface_get_width(argc=1)
div.v.v
call.i min(argc=2)
pop.v.v self.screenscale
exit.i

:[4]
push.i gml_Script_scr_create_pause_image
conv.i.v
pushi.e -1
conv.i.v
call.i method(argc=2)
dup.v 0
pushi.e -6
pop.v.v [stacktop]self.scr_create_pause_image
popz.v
b [6]

> gml_Script_scr_draw_pause_image (locals=0, argc=0)
:[5]
pushi.e 0
conv.b.v
pushi.e 0
conv.i.v
pushi.e 0
conv.i.v
pushi.e 0
conv.i.v
pushi.e 0
conv.i.v
push.v 291.actual_height
push.v 291.actual_width
pushi.e 0
conv.i.v
pushi.e 0
conv.i.v
call.i draw_rectangle_color(argc=9)
popz.v
pushi.e 1
conv.i.v
push.i 16777215
conv.i.v
pushi.e 0
conv.i.v
push.v self.screenscale
push.v self.screenscale
pushi.e 0
conv.i.v
pushi.e 0
conv.i.v
pushi.e 0
conv.i.v
push.v self.screensprite
call.i draw_sprite_ext(argc=9)
popz.v
pushi.e 1
conv.i.v
push.i 16777215
conv.i.v
pushi.e 0
conv.i.v
pushi.e 1
conv.i.v
pushi.e 1
conv.i.v
pushi.e 0
conv.i.v
pushi.e 0
conv.i.v
pushi.e 0
conv.i.v
push.v self.guisprite
call.i draw_sprite_ext(argc=9)
popz.v
exit.i

:[6]
push.i gml_Script_scr_draw_pause_image
conv.i.v
pushi.e -1
conv.i.v
call.i method(argc=2)
dup.v 0
pushi.e -6
pop.v.v [stacktop]self.scr_draw_pause_image
popz.v
b [8]

> gml_Script_scr_pause_stop_sounds (locals=0, argc=0)
:[7]
pushi.e 1
conv.b.v
pushglb.v global.snd_alarm
call.i fmod_event_instance_stop(argc=2)
popz.v
pushi.e 1
conv.b.v
pushglb.v global.snd_bossbeaten
call.i fmod_event_instance_stop(argc=2)
popz.v
pushi.e 1
conv.b.v
pushglb.v global.snd_spaceship
call.i fmod_event_instance_stop(argc=2)
popz.v
pushi.e 1
conv.b.v
pushglb.v global.snd_escaperumble
call.i fmod_event_instance_stop(argc=2)
popz.v
pushi.e 1
conv.b.v
pushglb.v global.snd_johndead
call.i fmod_event_instance_stop(argc=2)
popz.v
exit.i

:[8]
push.i gml_Script_scr_pause_stop_sounds
conv.i.v
pushi.e -1
conv.i.v
call.i method(argc=2)
dup.v 0
pushi.e -6
pop.v.v [stacktop]self.scr_pause_stop_sounds
popz.v
b [14]

> gml_Script_scr_delete_pause_image (locals=0, argc=0)
:[9]
push.v self.screensprite
call.i sprite_exists(argc=1)
conv.v.b
bf [11]

:[10]
push.v self.screensprite
call.i sprite_delete(argc=1)
popz.v

:[11]
push.v self.guisprite
call.i sprite_exists(argc=1)
conv.v.b
bf [13]

:[12]
push.v self.guisprite
call.i sprite_delete(argc=1)
popz.v

:[13]
exit.i

:[14]
push.i gml_Script_scr_delete_pause_image
conv.i.v
pushi.e -1
conv.i.v
call.i method(argc=2)
dup.v 0
pushi.e -6
pop.v.v [stacktop]self.scr_delete_pause_image
popz.v
b [22]

> gml_Script_scr_pauseicon_add (locals=0, argc=4)
:[15]
push.v arg.argument2
pushbltn.v builtin.undefined
cmp.v.v EQ
bf [17]

:[16]
pushi.e 0
pop.v.i arg.argument2

:[17]
push.v arg.argument3
pushbltn.v builtin.undefined
cmp.v.v EQ
bf [19]

:[18]
pushi.e 0
pop.v.i arg.argument3

:[19]
push.v arg.argument3
push.v arg.argument2
push.v arg.argument1
push.v arg.argument0
b [21]

> gml_Script____struct___52_scr_pauseicon_add_gml_GlobalScript_scr_pause (locals=0, argc=0)
:[20]
pushi.e -15
pushi.e 0
push.v [array]self.argument
pop.v.v self.sprite_index
pushi.e -15
pushi.e 1
push.v [array]self.argument
pop.v.v self.image_index
pushi.e 0
pop.v.i self.image_alpha
pushi.e -15
pushi.e 2
push.v [array]self.argument
pop.v.v self.sprite_xoffset
pushi.e -15
pushi.e 3
push.v [array]self.argument
pop.v.v self.sprite_yoffset
pushi.e 0
pop.v.i self.shake_x
pushi.e 0
pop.v.i self.shake_y
exit.i

:[21]
push.i gml_Script____struct___52_scr_pauseicon_add_gml_GlobalScript_scr_pause
conv.i.v
call.i @@NullObject@@(argc=0)
call.i method(argc=2)
dup.v 0
pushi.e -16
pop.v.v [stacktop]static.___struct___52
call.i @@NewGMLObject@@(argc=5)
push.v self.pause_icons
call.i array_push(argc=2)
popz.v
exit.i

:[22]
push.i gml_Script_scr_pauseicon_add
conv.i.v
pushi.e -1
conv.i.v
call.i method(argc=2)
dup.v 0
pushi.e -6
pop.v.v [stacktop]self.scr_pauseicon_add
popz.v
b [31]

> gml_Script_scr_pauseicons_update (locals=1, argc=1)
:[23]
pushi.e 0
pop.v.i local.i

:[24]
pushloc.v local.i
push.v self.pause_icons
call.i array_length(argc=1)
cmp.v.v LT
bf [30]

:[25]
pushi.e -1
pushloc.v local.i
conv.v.i
push.v [array]self.pause_icons
pushi.e -9
pushenv [29]

:[26]
pushloc.v local.i
push.v arg.argument0
cmp.v.v EQ
bf [28]

:[27]
pushi.e 1
conv.i.v
pushi.e -1
conv.i.v
call.i random_range(argc=2)
pop.v.v self.shake_x
pushi.e 1
conv.i.v
pushi.e -1
conv.i.v
call.i random_range(argc=2)
pop.v.v self.shake_y
push.d 0.2
conv.d.v
pushi.e 1
conv.i.v
push.v self.image_alpha
call.i gml_Script_Approach(argc=3)
pop.v.v self.image_alpha
b [29]

:[28]
pushi.e 0
pop.v.i self.shake_x
pushi.e 0
pop.v.i self.shake_y
push.d 0.2
conv.d.v
pushi.e 0
conv.i.v
push.v self.image_alpha
call.i gml_Script_Approach(argc=3)
pop.v.v self.image_alpha

:[29]
popenv [26]
push.v local.i
push.e 1
add.i.v
pop.v.v local.i
b [24]

:[30]
exit.i

:[31]
push.i gml_Script_scr_pauseicons_update
conv.i.v
pushi.e -1
conv.i.v
call.i method(argc=2)
dup.v 0
pushi.e -6
pop.v.v [stacktop]self.scr_pauseicons_update
popz.v
b [43]

> gml_Script_scr_pause_activate_objects (locals=1, argc=1)
:[32]
push.v arg.argument0
pushbltn.v builtin.undefined
cmp.v.v EQ
bf [34]

:[33]
pushi.e 1
pop.v.b arg.argument0

:[34]
pushi.e 0
pop.v.i local.i

:[35]
pushloc.v local.i
push.v self.instance_list
call.i ds_list_size(argc=1)
cmp.v.v LT
bf [37]

:[36]
pushloc.v local.i
push.v self.instance_list
call.i ds_list_find_value(argc=2)
call.i instance_activate_object(argc=1)
popz.v
push.v local.i
push.e 1
add.i.v
pop.v.v local.i
b [35]

:[37]
push.v arg.argument0
conv.v.b
bf [42]

:[38]
pushi.e 0
pop.v.i local.i

:[39]
pushloc.v local.i
push.v self.sound_list
call.i ds_list_size(argc=1)
cmp.v.v LT
bf [41]

:[40]
pushi.e 0
conv.b.v
pushloc.v local.i
push.v self.sound_list
call.i ds_list_find_value(argc=2)
call.i fmod_event_instance_set_paused(argc=2)
popz.v
push.v local.i
push.e 1
add.i.v
pop.v.v local.i
b [39]

:[41]
pushi.e 0
conv.b.v
call.i fmod_event_instance_set_paused_all(argc=1)
popz.v

:[42]
push.v self.instance_list
call.i ds_list_clear(argc=1)
popz.v
push.v self.sound_list
call.i ds_list_clear(argc=1)
popz.v
pushi.e 0
pop.v.b self.fadein
pushi.e 0
pop.v.b self.pause
push.i 36964855
setowner.e
pushi.e 1
conv.i.v
pushi.e -1
pushi.e 2
pop.v.v [array]self.alarm
exit.i

:[43]
push.i gml_Script_scr_pause_activate_objects
conv.i.v
pushi.e -1
conv.i.v
call.i method(argc=2)
dup.v 0
pushi.e -6
pop.v.v [stacktop]self.scr_pause_activate_objects
popz.v
b [59]

> gml_Script_scr_pause_deactivate_objects (locals=2, argc=1)
:[44]
push.v arg.argument0
pushbltn.v builtin.undefined
cmp.v.v EQ
bf [46]

:[45]
pushi.e 1
pop.v.b arg.argument0

:[46]
push.v arg.argument0
conv.v.b
bf [48]

:[47]
pushi.e 1
conv.b.v
call.i fmod_event_instance_set_paused_all(argc=1)
popz.v

:[48]
push.v self.instance_list
call.i ds_list_clear(argc=1)
popz.v
pushi.e 0
pop.v.i local.i

:[49]
pushloc.v local.i
pushbltn.v builtin.instance_count
cmp.v.v LT
bf [58]

:[50]
pushloc.v local.i
pushi.e -3
conv.i.v
call.i instance_find(argc=2)
pop.v.v local.obj
pushloc.v local.obj
call.i instance_exists(argc=1)
conv.v.b
bf [54]

:[51]
pushloc.v local.obj
pushi.e -9
push.v [stacktop]self.object_index
pushi.e 588
cmp.i.v NEQ
bf [54]

:[52]
pushloc.v local.obj
pushi.e -9
push.v [stacktop]self.object_index
pushi.e 617
cmp.i.v NEQ
bf [54]

:[53]
pushloc.v local.obj
pushi.e -9
push.v [stacktop]self.object_index
pushi.e 291
cmp.i.v NEQ
b [55]

:[54]
push.e 0

:[55]
bf [57]

:[56]
pushloc.v local.obj
push.v self.instance_list
call.i ds_list_add(argc=2)
popz.v

:[57]
push.v local.i
push.e 1
add.i.v
pop.v.v local.i
b [49]

:[58]
pushi.e 1
conv.b.v
call.i instance_deactivate_all(argc=1)
popz.v
pushi.e 617
conv.i.v
call.i instance_activate_object(argc=1)
popz.v
pushi.e 471
conv.i.v
call.i instance_activate_object(argc=1)
popz.v
pushi.e 588
conv.i.v
call.i instance_activate_object(argc=1)
popz.v
pushi.e 291
conv.i.v
call.i instance_activate_object(argc=1)
popz.v
pushi.e 589
conv.i.v
call.i instance_activate_object(argc=1)
popz.v
pushi.e 127
conv.i.v
call.i instance_activate_object(argc=1)
popz.v
pushi.e 215
conv.i.v
call.i instance_activate_object(argc=1)
popz.v
pushi.e 1206
conv.i.v
call.i instance_activate_object(argc=1)
popz.v
pushi.e 1207
conv.i.v
call.i instance_activate_object(argc=1)
popz.v
exit.i

:[59]
push.i gml_Script_scr_pause_deactivate_objects
conv.i.v
pushi.e -1
conv.i.v
call.i method(argc=2)
dup.v 0
pushi.e -6
pop.v.v [stacktop]self.scr_pause_deactivate_objects
popz.v
b [68]

> gml_Script_pause_spawn_priests (locals=2, argc=0)
:[60]
pushi.e 3133
conv.i.v
pushi.e 1621
conv.i.v
pushi.e 3712
conv.i.v
call.i choose(argc=3)
pushi.e 1
conv.i.v
pushi.e -1
conv.i.v
call.i choose(argc=2)
push.d 1.4
conv.d.v
push.d 0.8
conv.d.v
call.i random_range(argc=2)
push.v 291.actual_height
pushi.e 200
add.i.v
b [62]

> gml_Script____struct___53_pause_spawn_priests_gml_GlobalScript_scr_pause (locals=0, argc=0)
:[61]
pushi.e 0
pop.v.i self.x
pushi.e -15
pushi.e 0
push.v [array]self.argument
pop.v.v self.y
pushi.e -15
pushi.e 1
push.v [array]self.argument
pop.v.v self.speed
pushi.e 0
pop.v.i self.image_index
push.d 0.35
pop.v.d self.image_speed
pushi.e -15
pushi.e 2
push.v [array]self.argument
pop.v.v self.image_xscale
pushi.e 0
pop.v.i self.image_alpha
pushi.e -15
pushi.e 3
push.v [array]self.argument
pop.v.v self.sprite_index
exit.i

:[62]
push.i gml_Script____struct___53_pause_spawn_priests_gml_GlobalScript_scr_pause
conv.i.v
call.i @@NullObject@@(argc=0)
call.i method(argc=2)
dup.v 0
pushi.e -16
pop.v.v [stacktop]static.___struct___53
call.i @@NewGMLObject@@(argc=5)
pop.v.v local.p
push.l 1
conv.l.v
call.i gml_Script_is_holiday(argc=1)
conv.v.b
bf [64]

:[63]
pushi.e 1576
conv.i.v
pushi.e 2070
conv.i.v
pushi.e 1263
conv.i.v
call.i choose(argc=3)
pushloc.v local.p
pushi.e -9
pop.v.v [stacktop]self.sprite_index

:[64]
pushi.e 100
conv.i.v
call.i irandom(argc=1)
pop.v.v local.q
pushloc.v local.q
pushi.e 50
cmp.i.v GTE
bf [66]

:[65]
push.v 291.actual_width
push.d 0.65
mul.d.v
push.v 291.actual_width
push.d 0.78
mul.d.v
call.i irandom_range(argc=2)
pushloc.v local.p
pushi.e -9
pop.v.v [stacktop]self.x
b [67]

:[66]
push.d 0.42
conv.d.v
push.v 291.actual_width
push.d 0.2
mul.d.v
call.i irandom_range(argc=2)
pushloc.v local.p
pushi.e -9
pop.v.v [stacktop]self.x

:[67]
pushloc.v local.p
push.v self.priest_list
call.i ds_list_add(argc=2)
popz.v
exit.i

:[68]
push.i gml_Script_pause_spawn_priests
conv.i.v
pushi.e -1
conv.i.v
call.i method(argc=2)
dup.v 0
pushi.e -6
pop.v.v [stacktop]self.pause_spawn_priests
popz.v
b [74]

> gml_Script_pause_unpause_music (locals=0, argc=0)
:[69]
pushi.e 589
pushenv [73]

:[70]
push.v self.music
pushi.e -4
cmp.i.v NEQ
bf [72]

:[71]
push.v other.savedmusicpause
push.v self.music
pushi.e -9
push.v [stacktop]self.event
call.i fmod_event_instance_set_paused(argc=2)
popz.v
push.v other.savedsecretpause
push.v self.music
pushi.e -9
push.v [stacktop]self.event_secret
call.i fmod_event_instance_set_paused(argc=2)
popz.v

:[72]
push.v other.savedpillarpause
push.v self.pillarmusicID
call.i fmod_event_instance_set_paused(argc=2)
popz.v
push.v other.savedpanicpause
push.v self.panicmusicID
call.i fmod_event_instance_set_paused(argc=2)
popz.v
push.v other.savedkidspartypause
push.v self.kidspartychaseID
call.i fmod_event_instance_set_paused(argc=2)
popz.v

:[73]
popenv [70]
pushi.e 1
conv.b.v
push.v self.pausemusicID
call.i fmod_event_instance_stop(argc=2)
popz.v
exit.i

:[74]
push.i gml_Script_pause_unpause_music
conv.i.v
pushi.e -1
conv.i.v
call.i method(argc=2)
dup.v 0
pushi.e -6
pop.v.v [stacktop]self.pause_unpause_music
popz.v
b [94]

> gml_Script_pause_update_priests (locals=4, argc=0)
:[75]
pushi.e 0
pop.v.i local.i

:[76]
pushloc.v local.i
push.v self.priest_list
call.i ds_list_size(argc=1)
cmp.v.v LT
bf [93]

:[77]
pushloc.v local.i
push.v self.priest_list
call.i ds_list_find_value(argc=2)
pop.v.v local.b
pushi.e 0
pop.v.b local.destroy
pushloc.v local.b
pushi.e -9
pushenv [90]

:[78]
push.v self.y
push.v self.speed
sub.v.v
pop.v.v self.y
push.v self.image_index
push.v self.image_speed
add.v.v
pop.v.v self.image_index
push.v other.pause
conv.v.b
not.b
bf [83]

:[79]
push.v self.x
push.v self.x
push.v 291.actual_width
pushi.e 2
conv.i.d
div.d.v
cmp.v.v GT
bf [81]

:[80]
pushi.e 10
conv.i.v
b [82]

:[81]
pushi.e -10
conv.i.v

:[82]
add.v.v
pop.v.v self.x

:[83]
push.v self.y
pushi.e -200
cmp.i.v LT
bf [85]

:[84]
pushi.e 1
pop.v.b local.destroy

:[85]
push.d 0.02
pop.v.d local.a
push.v self.y
pushi.e 250
cmp.i.v GT
bf [89]

:[86]
push.v self.y
push.v 291.actual_height
pushi.e 100
sub.i.v
cmp.v.v LT
bf [88]

:[87]
push.v self.image_alpha
pushloc.v local.a
add.v.v
pop.v.v self.image_alpha

:[88]
b [90]

:[89]
push.v self.image_alpha
pushloc.v local.a
sub.v.v
pop.v.v self.image_alpha

:[90]
popenv [78]
pushloc.v local.destroy
conv.v.b
bf [92]

:[91]
pushbltn.v builtin.undefined
pop.v.v local.b
push.v local.i
dup.v 0
push.e 1
sub.i.v
pop.v.v local.i
push.v self.priest_list
call.i ds_list_delete(argc=2)
popz.v

:[92]
push.v local.i
push.e 1
add.i.v
pop.v.v local.i
b [76]

:[93]
exit.i

:[94]
push.i gml_Script_pause_update_priests
conv.i.v
pushi.e -1
conv.i.v
call.i method(argc=2)
dup.v 0
pushi.e -6
pop.v.v [stacktop]self.pause_update_priests
popz.v
b [101]

> gml_Script_pause_draw_priests (locals=2, argc=0)
:[95]
pushi.e 0
pop.v.i local.i

:[96]
pushloc.v local.i
push.v self.priest_list
call.i ds_list_size(argc=1)
cmp.v.v LT
bf [100]

:[97]
pushloc.v local.i
push.v self.priest_list
call.i ds_list_find_value(argc=2)
pop.v.v local.b
pushloc.v local.b
pushi.e -9
pushenv [99]

:[98]
push.v self.image_alpha
push.i 16777215
conv.i.v
pushi.e 0
conv.i.v
pushi.e 1
conv.i.v
push.v self.image_xscale
push.v self.y
push.v self.x
push.v self.image_index
push.v self.sprite_index
call.i draw_sprite_ext(argc=9)
popz.v

:[99]
popenv [98]
push.v local.i
push.e 1
add.i.v
pop.v.v local.i
b [96]

:[100]
exit.i

:[101]
push.i gml_Script_pause_draw_priests
conv.i.v
pushi.e -1
conv.i.v
call.i method(argc=2)
dup.v 0
pushi.e -6
pop.v.v [stacktop]self.pause_draw_priests
popz.v

:[end]