//Display settings
display_reset(4,false);
application_surface_enable(false);
gpu_set_texfilter(true);
gpu_set_tex_mip_enable(true);
data_define();
texturegroup_load("default");
randomize();

choose_poem=1;
choose_queue=false;
audio_queue=false;

//Define settings
settings_dakuten=true;
settings_number=true;
settings_handwrite=true;
settings_flip=false;
settings_mark=true;
settings_poem=true;
settings_red=true;
settings_syllable=true;
settings_beginner=true;
settings_romaji=true;
load_settings();

flip_state=true;
flip_tween=true;
drop_value=0;

button_color=c_white;
srs_create();