//Display settings
display_reset(4,false);
application_surface_enable(false);
gpu_set_texfilter(true);
gpu_set_tex_mip_enable(true);
data_define();

randomize();
choose_poem=irandom_range(1,100);
choose_queue=false;
audio_queue=false;

settings_dakuten=true;
settings_number=true;
settings_handwrite=true;
settings_flip=false;
settings_mark=true;
settings_poem=true;

flip_state=0;
flip_tween=0;