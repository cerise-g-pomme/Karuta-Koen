draw_sprite_tiled_ext(sprite_tatami,0,0,0,1,1,c_white,0.02);

var center_x=window_get_width()*0.5;
var center_y=window_get_height()*0.46;
var scale=min(1,window_get_height()/1050);
flip_tween=flip_tween*0.8+flip_state*0.2;

karuta_ui(center_x,center_y,scale,choose_poem);

var drop_smoothed=math_ease(clamp((1-drop_value)*1.2,0,1));
drop_value=max(0,drop_value*0.8);
if (drop_value>0.01)karuta_draw(center_x,center_y,scale,choose_old,1);
karuta_draw(center_x+100*scale*drop_value,center_y-300*scale*drop_value,scale,choose_poem,drop_smoothed);

