function karuta_draw(x,y,scale){
	//Get the name of the poem
	var poem_name="poem_"+string(choose_poem);
	var poem_index=struct_get(poem_struct,poem_name);
	var string_torifuda=poem_index.part2;
	if(settings_dakuten)string_torifuda=remove_dakuten(string_torifuda);
	//Draw the card
	var flip=1-flip_tween*2;
	var flipped=(flip_tween>0.5);
	draw_sprite_ext(sprite_card,flipped,x,y,scale*flip,scale,0,c_white,1);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_font(font_hirigana);
	//Draw the numeral
	if (settings_number&&flipped){
		draw_set_color(c_white);
		draw_sprite_ext(sprite_circle,0,x,y-418*scale,scale*0.6*flip,scale*0.6,0,c_white,1);
		draw_text_transformed(x,y-418*scale,choose_poem,-scale*0.3*flip,scale*0.3,0);
	}
	if (settings_flip)scale*=-1;
	//Format the string renderer
	if (settings_handwrite)draw_set_font(font_hirigana_cursive);
	draw_set_color(c_black);
	//Draw the lines
	var x_start=x-155*scale*flip;
	var y_start=y-310*scale;
	var x_draw=x_start;
	var y_draw=y_start;
	var y_offset=150*scale;
	var x_offset=-155*scale*flip;
	var string_clip="";
	if (flipped){
		for (var i=0;i<3;++i){
		    //Draw each column
			string_clip=string_copy(string_torifuda,1,5);
			string_torifuda=string_copy(string_torifuda,6,string_length(string_torifuda)-5);
			for (var j=0;j<5;++j){
				//Draw each character
				draw_text_transformed(x_draw,y_draw,string_char_at(string_clip,j+1),-scale*flip,scale,0);
				y_draw+=y_offset;
			}
			x_draw-=x_offset;
			y_draw=y_start;
		}
	}
	//Draw the mark
	if (flipped&&settings_mark)
		draw_sprite_ext(sprite_mark,poem_index.mark_n,x_start+x_offset*(poem_index.mark_x-3),y_start+y_offset*(poem_index.mark_y-1),-scale*flip,scale,0,c_white,1);
	if (settings_flip)scale*=-1;
	//Draw the full poem
	draw_set_font(font_hirigana);
	draw_sprite_ext(sprite_back,0,x+395*scale,y,scale,scale,0,c_white,1);
	draw_set_color(c_white);
	scale*=0.4;
	if (settings_poem){
		x_draw=x+1060*scale;
		y_draw=y-980*scale;
		y_offset=115*scale;
		var string_yamafuda=poem_index.part1;
		for (var i=0;i<string_length(string_yamafuda);++i) {
			//Draw each character
			draw_text_transformed(x_draw,y_draw,string_char_at(string_yamafuda,i+1),scale,scale,0);
			y_draw+=y_offset;
		}
		x_draw=x+910*scale;
		y_draw=y-980*scale;
		y_offset=120*scale;
		string_torifuda=poem_index.part2;
		for (var i=0;i<string_length(string_torifuda);++i) {
			//Draw each character
			draw_text_transformed(x_draw,y_draw,string_char_at(string_torifuda,i+1),scale,scale,0);
			y_draw+=y_offset;
		}
	}
	//Draw the buttons
	var button_x=x-900*scale;
	var button_y=y-980*scale;
	var sprite_speaking=sprite_speak_mute;
	if audio_is_playing(poem_index.sound) sprite_speaking=sprite_speak;
	draw_sprite_ext(sprite_speaking,current_time*0.015,button_x-250*scale,button_y+250*0*scale,scale,scale*0.5,0,c_white,1);
	if ui_button_sprite_draw(button_x,button_y+250*0*scale,sprite_button_sound,1*scale)||audio_queue{
		audio_queue=false;
		audio_stop_all();
		audio_play_sound(poem_index.sound,1,false);	
	}
	if ui_button_sprite_draw(button_x,button_y+250*1*scale,sprite_button_next,1*scale){
		audio_stop_all();
		flip_state=false;
		choose_queue=true;
	}
	//Option buttons
	button_x=x+1350*scale;
	button_y=y-1000*scale;
	var button_add=200*scale;
	scale*=0.75;
	if ui_button_sprite_draw(button_x,button_y,sprite_button_number,1*scale){settings_number=!settings_number;mouse_clear(mb_left);}button_y+=button_add;
	if ui_button_sprite_draw(button_x,button_y,sprite_button_dakuten,1*scale){settings_dakuten=!settings_dakuten;mouse_clear(mb_left);}button_y+=button_add;
	if ui_button_sprite_draw(button_x,button_y,sprite_button_handwrite,1*scale){settings_handwrite=!settings_handwrite;mouse_clear(mb_left);}button_y+=button_add;
	if ui_button_sprite_draw(button_x,button_y,sprite_button_rotate,1*scale){settings_flip=!settings_flip;mouse_clear(mb_left);}button_y+=button_add;
	if ui_button_sprite_draw(button_x,button_y,sprite_button_outline,1*scale){settings_mark=!settings_mark;mouse_clear(mb_left);}button_y+=button_add;
	if ui_button_sprite_draw(button_x,button_y,sprite_button_poem,1*scale){settings_poem=!settings_poem;mouse_clear(mb_left);}button_y+=button_add;
}