function karuta_draw(x,y,scale){
	//Get poem data
	var poem_name="poem_"+string(choose_poem);
	var poem_data=struct_get(poem_struct,poem_name);
	var poem_red_string=poem_data.second_verse_answer;
	var poem_red_count=string_length(poem_red_string)*settings_red;
	var poem_kimaraji=poem_data.kimariji;
	var poem_kimaraji_count=string_length(poem_kimaraji);
	var torifuda=poem_data.part2;
	
	//Get poem name and index
	if(settings_dakuten)torifuda=remove_dakuten(torifuda);

	//Card flip and draw
	var flip=1-flip_tween*2;
	var flipped=(flip_tween>0.5);
	draw_sprite_ext(sprite_card,flipped,x,y,scale*flip,scale,0,c_white,1);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_font(font_hirigana);

	//Draw number if enabled
	if(settings_number&&flipped){
		draw_set_color(c_white);
		draw_sprite_ext(sprite_circle,0,x,y-418*scale,scale*0.6*flip,scale*0.6,0,c_white,1);
		draw_text_transformed(x,y-418*scale,choose_poem,-scale*0.3*flip,scale*0.3,0);
	}

	//Flip correction
	if(settings_flip)scale*=-1;


	//Draw the beginner kimaraji
	if (settings_beginner&&flipped){
		draw_set_color(c_red);
		draw_set_alpha(0.2);
		var kima_x_start=x;
		var kima_y_start=y-270*scale;
		var kima_x=kima_x_start;
		var kima_y=kima_y_start;
		var kima_o_x=-110*scale*flip;
		var kima_o_y=240*scale;
		if (poem_kimaraji_count>3)kima_x+=kima_o_x;
		var character;
		var count=0;
		var scale_kima=scale*1.8;
		for (var i=0;i<poem_kimaraji_count;++i){
		    //Draw the beginner kimaraji
			character=string_char_at(poem_kimaraji,i+1);
			draw_text_transformed(kima_x,kima_y,character,-scale_kima*flip,scale_kima,0);
			kima_y+=kima_o_y;
			count++;
			if (count>2){count=0;kima_x-=kima_o_x*2;kima_y=kima_y_start;}
		}
	}

	//Text formatting
	if(settings_handwrite)draw_set_font(font_hirigana_cursive);

	//Draw lines of characters
	draw_set_color(c_black);
	draw_set_alpha(1);
	var count=poem_red_count;
	if (count)draw_set_color(c_red);
	var x0=x-155*scale*flip;
	var y0=y-310*scale;
	var y_step=150*scale;
	var x_step=-155*scale*flip;
	var clip="";
	if(flipped){
		for(var i=3;i>0;--i){
			clip=string_copy(torifuda,1,5);
			torifuda=string_copy(torifuda,6,string_length(torifuda)-5);
			for(var j=0;j<5;++j){
				draw_text_transformed(x0+i*x_step-x_step*3,y0+j*y_step,string_char_at(clip,j+1),-scale*flip,scale,0);
				count--;
				if (!count)draw_set_color(c_black);
	}}}

	//Draw mark
	if(flipped&&settings_mark)
		draw_sprite_ext(sprite_mark,poem_data.mark_n,x0+x_step*(poem_data.mark_x-3),y0+y_step*(poem_data.mark_y-1),-scale*flip,scale,0,c_white,1);
	if(settings_flip)scale*=-1;

	//Draw full poem
	draw_set_font(font_hirigana);
	draw_sprite_ext(sprite_back,0,x+470*scale,y,scale,scale,0,c_white,settings_poem);
	draw_set_color(c_white);
	var poem_scale=scale*0.4;
	if(settings_poem){
		var x_draw=x+1260*poem_scale;
		var y_draw=y-980*poem_scale;
		var y_step1=115*poem_scale;
		var y_step2=120*poem_scale;
		var yamafuda=poem_data.part1;
		for(var i=0;i<string_length(yamafuda);++i){
			draw_text_transformed(x_draw,y_draw,string_char_at(yamafuda,i+1),poem_scale*0.9,poem_scale*0.9,0);
			y_draw+=y_step1;
		}
		x_draw=x+1100*poem_scale;
		y_draw=y-980*poem_scale;
		torifuda=poem_data.part2;
		for(var i=0;i<string_length(torifuda);++i){
			draw_text_transformed(x_draw,y_draw,string_char_at(torifuda,i+1),poem_scale,poem_scale,0);
			y_draw+=y_step2;
		}
	}

	//Draw the kimaraji
	var left_drop=0;
	if (settings_syllable){
		draw_set_color(c_black);
		left_drop=150*scale;
		var kima_scale=scale*0.8;
		draw_sprite_ext(sprite_kimaraji,0,x-490*scale,y-370*scale,kima_scale,kima_scale,0,c_white,1);
		var hiri_scale=min(400/string_width(poem_kimaraji),1);
		draw_text_transformed(x-490*scale,y-370*scale,poem_kimaraji,kima_scale*hiri_scale,kima_scale*hiri_scale,0);
	}
	
	//Draw buttons
	var left_button_scale=scale*0.4;
	var bx=x-900*left_button_scale;
	var by=y-990*left_button_scale+left_drop;
	var speak_sprite=audio_is_playing(poem_data.sound)?sprite_speak:sprite_speak_mute;
	draw_sprite_ext(speak_sprite,current_time*0.015,bx-250*left_button_scale,by,left_button_scale,left_button_scale*0.5,0,c_white,1);
	if(ui_button_sprite_draw(bx,by,sprite_button_sound,left_button_scale)||audio_queue){
		audio_queue=false;
		audio_stop_all();
		audio_play_sound(poem_data.sound,1,false);
		mouse_clear(mb_left);
	}
	if(ui_button_sprite_draw(bx,by+250*left_button_scale,sprite_button_next,left_button_scale)){
		audio_stop_all();
		flip_state=false;
		choose_queue=true;
		mouse_clear(mb_left);
	}

	//Option buttons
	var right_button_scale=scale*0.3;
	bx=x+1130*right_button_scale;
	by=y-1340*right_button_scale;
	var step=270*right_button_scale;
	if(ui_button_sprite_draw(bx,by,sprite_button_number,right_button_scale)){settings_number=!settings_number;mouse_clear(mb_left);}by+=step;
	if(ui_button_sprite_draw(bx,by,sprite_button_dakuten,right_button_scale)){settings_dakuten=!settings_dakuten;mouse_clear(mb_left);}by+=step;
	if(ui_button_sprite_draw(bx,by,sprite_button_handwrite,right_button_scale)){settings_handwrite=!settings_handwrite;mouse_clear(mb_left);}by+=step;
	if(ui_button_sprite_draw(bx,by,sprite_button_rotate,right_button_scale)){settings_flip=!settings_flip;mouse_clear(mb_left);}by+=step;
	if(ui_button_sprite_draw(bx,by,sprite_button_red,right_button_scale)){settings_red=!settings_red;mouse_clear(mb_left);}by+=step;
	if(ui_button_sprite_draw(bx,by,sprite_button_outline,right_button_scale)){settings_mark=!settings_mark;mouse_clear(mb_left);}by+=step;
	if(ui_button_sprite_draw(bx,by,sprite_button_kimariji,right_button_scale)){settings_beginner=!settings_beginner;mouse_clear(mb_left);}by+=step;
	if(ui_button_sprite_draw(bx,by,sprite_button_poem,right_button_scale)){settings_poem=!settings_poem;mouse_clear(mb_left);}by+=step;
	if(ui_button_sprite_draw(bx,by,sprite_button_syllable,right_button_scale)){settings_syllable=!settings_syllable;mouse_clear(mb_left);}by+=step;
	
	if mouse_check_button_released(mb_left)&&!flip_state{
		flip_state=true;
	}
	if (choose_queue&(flip_tween<0.5)){
		choose_poem=irandom_range(1,100);
		choose_queue=false;
		audio_queue=true;
	}
	flip_tween=flip_tween*0.8+flip_state*0.2;
	
}
