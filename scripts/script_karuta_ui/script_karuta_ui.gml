function karuta_ui(x,y,scale,index){
    //Get poem data
    var poem_name="poem_"+string(index);
    var poem_data=struct_get(poem_struct,poem_name);
    var poem_kimaraji=poem_data.kimariji;
    var poem_kimaraji_romanji=hiragana_to_romaji(poem_kimaraji);
    var torifuda=poem_data.part2;
    //Draw full poem background
	button_color=546816;
    draw_set_alpha(1);
    draw_set_font(font_hirigana);
    draw_sprite_ext(sprite_back,0,x+400*scale,y,scale,scale,0,merge_color(c_white,c_black,0.9),settings_poem);//546816 341504
    //Draw poem text
    if (settings_poem){
		draw_set_color(c_white);
        var poem_scale=scale*0.4;
        var text_scale=poem_scale*1.8;
        var y_step1=115*poem_scale;
        var y_step2=120*poem_scale;
        //Draw part1
        var x_draw=x+1080*poem_scale;
        var y_draw=y-980*poem_scale;
        var part1=poem_data.part1;
        for (var i=0; i < string_length(part1);++i){
            draw_text_transformed(x_draw,y_draw,string_char_at(part1,i+1),text_scale,text_scale,0);
            y_draw+=y_step1;
		}
        //Draw part2
        x_draw=x+920*poem_scale;
        y_draw=y-980*poem_scale;
        for (var i=0; i < string_length(torifuda);++i){
            draw_text_transformed(x_draw,y_draw,string_char_at(torifuda,i+1),text_scale,text_scale,0);
            y_draw+=y_step2;
	    }
	}
    //Draw kimaraji
    var left_drop=0;
    var kima_scale=scale*0.8;
    if (settings_syllable){
        draw_set_color(c_white);
        draw_sprite_ext(sprite_kimaraji,0,x-490*scale,y-280*scale,kima_scale,kima_scale,0,merge_color(c_white,c_black,0.9),1);
        var hiri_scale=min(200 / string_width(poem_kimaraji),1)*2;
        draw_text_transformed(x-490*scale,y-280*scale,poem_kimaraji,kima_scale*hiri_scale,kima_scale*hiri_scale,0);
		left_drop+=150*scale;
	}
	//Draw romaji kimaraji
    if (settings_romaji){
        draw_set_color(c_white);
		draw_sprite_ext(sprite_kimaraji,0,x-490*scale,y-280*scale+left_drop,kima_scale,kima_scale,0,merge_color(c_white,c_black,0.9),1);
        var romanji_scale=min(260 / string_width(poem_kimaraji_romanji),1)*1.5;
        draw_text_transformed(x-490*scale,y-280*scale+left_drop,poem_kimaraji_romanji,kima_scale*romanji_scale,kima_scale*romanji_scale,0);
		left_drop+=150*scale;
	}
	// Draw audio button
	button_color=c_white;
	var left_button_scale=scale*0.8;
	var left_button_scale_half=left_button_scale*0.5;
	var left_button_scale_08=scale*0.6;
	var bx=x-430*left_button_scale;
	var by=y-500*left_button_scale;
	var is_playing = audio_is_playing(poem_data.sound);
	var speak_sprite = is_playing ? sprite_speak : sprite_speak_mute;
	// Use precalculated rotation angle
	var rotation = current_time * 0.015;
	// Draw the sprite
	draw_sprite_ext(speak_sprite,rotation,bx-120*left_button_scale,by,left_button_scale,left_button_scale_half,0,c_white,1);
	// Check for click
	if (ui_button_sprite_draw(bx,by,sprite_button_sound,left_button_scale_08)||audio_queue) {
	    audio_queue = false;
	    audio_stop_all();
	    audio_play_sound(poem_data.sound, 1, false);
	    mouse_clear(mb_left);
	}
    //Option buttons
	button_color=546816;
    var right_button_scale=scale*0.6;
    bx=window_get_width()-100*right_button_scale;
    by=100*right_button_scale;
    var step=130*right_button_scale;
	//Draw the buttons
    if (ui_button_sprite_draw(bx,by,sprite_button_number,right_button_scale)){ settings_number=!settings_number;mouse_clear(mb_left);save_settings();} by+=step;
    if (ui_button_sprite_draw(bx,by,sprite_button_dakuten,right_button_scale)){ settings_dakuten=!settings_dakuten;mouse_clear(mb_left);save_settings();} by+=step;
    if (ui_button_sprite_draw(bx,by,sprite_button_handwrite,right_button_scale)){ settings_handwrite=!settings_handwrite;mouse_clear(mb_left);save_settings();} by+=step;
    if (ui_button_sprite_draw(bx,by,sprite_button_rotate,right_button_scale)){ settings_flip=!settings_flip;mouse_clear(mb_left);save_settings();} by+=step;
    if (ui_button_sprite_draw(bx,by,sprite_button_red,right_button_scale)){ settings_red=!settings_red;mouse_clear(mb_left);save_settings();} by+=step;
    if (ui_button_sprite_draw(bx,by,sprite_button_outline,right_button_scale)){ settings_mark=!settings_mark;mouse_clear(mb_left);save_settings();} by+=step;
    if (ui_button_sprite_draw(bx,by,sprite_button_kimariji,right_button_scale)){ settings_beginner=!settings_beginner;mouse_clear(mb_left);save_settings();} by+=step;
    if (ui_button_sprite_draw(bx,by,sprite_button_poem,right_button_scale)){ settings_poem=!settings_poem;mouse_clear(mb_left);save_settings();} by+=step;
    if (ui_button_sprite_draw(bx,by,sprite_button_syllable,right_button_scale)){ settings_syllable=!settings_syllable;mouse_clear(mb_left);save_settings();} by+=step;
    if (ui_button_sprite_draw(bx,by,sprite_button_romaji,right_button_scale)){ settings_romaji=!settings_romaji;mouse_clear(mb_left);save_settings();} by+=step;
    //SRS buttons
	button_color=c_white;
    draw_set_color(c_black);
    var srs_offset_x=145*scale;
    var srs_y=y+480*scale;
    var srs_scale=scale*0.5;
    var font_scale=srs_scale;
    var proceed=false;
    var srs_labels=["Forgot","Bad","Okay","Good","Great"];
    for (var i=0;i<=4;++i){
        var sx=x+(i-2)*srs_offset_x;
        if (ui_button_sprite_index_draw(sx,srs_y,sprite_srs,srs_scale,i+1)){
			srs_review_card(srs_load_card(index),i);
            proceed=true;
            mouse_clear(mb_left);
		}
        draw_text_transformed(sx,srs_y,srs_labels[i],font_scale,font_scale,0);
		draw_text_transformed(sx-57*scale,srs_y-14*scale,string(i+1)+".",font_scale*0.5,font_scale*0.5,0);
	}
    if (proceed){
        audio_stop_all();
        choose_old=choose_poem;
        mouse_clear(mb_left);
        drop_value=1;
		//Find the new card
		var next_card=srs_get_next_card();
		choose_poem=next_card.cardID;
	}
}


	/*
	if(ui_button_sprite_draw(bx,by+250*left_button_scale,sprite_button_next,left_button_scale)){
		audio_stop_all();
		flip_state=false;
		choose_queue=true;
		poem_pull=true;
		mouse_clear(mb_left);
	}*/
	
	/*
	if mouse_check_button_released(mb_left)&&!flip_state{
		flip_state=true;
	}
	if (choose_queue&(flip_tween<0.5)){
		choose_poem=irandom_range(1,100);
		choose_queue=false;
		audio_queue=true;
	}
	
	*/