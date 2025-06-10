function ui_button_sprite_draw(x,y,sprite,scale){
	var input=false;
	var offset=10*scale;
	var input_x=device_mouse_x_to_gui(0),input_y=device_mouse_y_to_gui(0);
	var sprite_w=sprite_get_width(sprite)*scale,sprite_h=sprite_get_height(sprite)*scale;
	var draw_x=x,draw_y=y;
	if (abs(x-input_x)<(sprite_w*0.5))
	&& (abs(y-input_y)<(sprite_h*0.5)){
		//Mouseover
		scale*=1.05;
		if mouse_check_button(mb_left){
			//Mouse press
			draw_x+=offset;
			draw_y+=offset;
		}
		if mouse_check_button_released(mb_left){
			input=true;
		}
	}
	draw_sprite_ext(sprite,0,draw_x,draw_y,scale,scale,0,button_color,1);
	return input;
}
function ui_button_sprite_index_draw(x,y,sprite,scale,index){
	var input=false;
	var offset=10*scale;
	var input_x=device_mouse_x_to_gui(0),input_y=device_mouse_y_to_gui(0);
	var sprite_w=sprite_get_width(sprite)*scale,sprite_h=sprite_get_height(sprite)*scale;
	var draw_x=x,draw_y=y;
	var mouse=(abs(x-input_x)<(sprite_w*0.5))&&(abs(y-input_y)<(sprite_h*0.5));
	//Mouseover
	scale*=1.05;
	if (mouse&&mouse_check_button(mb_left))||keyboard_check(ord(string(index))){
		//Mouse press
		draw_x+=offset;
		draw_y+=offset;
	}
	if (mouse&&mouse_check_button_released(mb_left))||keyboard_check_released(ord(string(index))){
		input=true;
	}
	draw_sprite_ext(sprite,0,draw_x,draw_y,scale,scale,0,button_color,1);
	return input;
}