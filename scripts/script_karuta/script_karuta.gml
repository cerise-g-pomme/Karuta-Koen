function karuta_draw(x,y,scale,index,alpha){
    //Get poem data
    var poem_name="poem_"+string(index);
    var poem_data=struct_get(poem_struct,poem_name);
    var red_str=poem_data.second_verse_answer;
    var red_count=string_length(red_str);
    var kimaraji=poem_data.kimariji;
    var kima_count=string_length(kimaraji);
    var torifuda=poem_data.part2;
    var torifuda_str=settings_dakuten ? remove_dakuten(torifuda) : torifuda;
    //Card flip
    var flip=1-flip_tween*2;
    var flipped=(flip_tween>0.5);
    draw_sprite_ext(sprite_card,flipped,x,y,scale*flip,scale,0,c_white,alpha);
    //Basic draw settings
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(settings_handwrite ? font_hirigana_cursive : font_hirigana);
    draw_set_alpha(alpha);
    //Draw number
    if (settings_number*settings_hide_all && flipped){
        var num_scale=scale*0.6;
        var num_y=y-418*scale;
        draw_set_color(c_white);
        draw_sprite_ext(sprite_circle,0,x,num_y,num_scale*flip,num_scale,0,c_white,alpha);
        draw_text_transformed(x,num_y,index,-num_scale*flip,num_scale,0);
    }
    //Flip correction
    if (settings_flip) scale*=-1;
    //Draw beginner kimaraji
    if (settings_beginner*settings_hide_all && flipped){
        draw_set_color(c_red);
        draw_set_alpha(0.2*alpha);
        var kima_x=x;
        var kima_y=y-270*scale;
        var kima_off_x=-110*scale*flip;
        var kima_off_y=240*scale;
        if (kima_count>3) kima_x+=kima_off_x;
        var scale_kima=scale*3.6;
        var count=0;
        for (var i=0;i < kima_count;++i){
            var char=string_char_at(kimaraji,i+1);
            draw_text_transformed(kima_x,kima_y,char,-scale_kima*flip,scale_kima,0);
            kima_y+=kima_off_y;
            if (++count>2){
                count=0;
                kima_x -= kima_off_x*2;
                kima_y=y-270*scale;
            }
        }
    }
    //Draw mark
    if (flipped && settings_mark*settings_hide_all){
        var mark_x=x-155*scale*flip+-155*scale*flip*(poem_data.mark_x-3);
        var mark_y=y-310*scale+150*scale*(poem_data.mark_y-1);
        draw_sprite_ext(sprite_mark,poem_data.mark_n,mark_x,mark_y,-scale*flip,scale,0,c_white,alpha);
    }
    //Text color for torifuda
    draw_set_color(settings_red*settings_hide_all && red_count ? c_red : c_black);
    draw_set_alpha(alpha);
    //Draw torifuda
    if (flipped){
        var x0=x-155*scale*flip;
        var y0=y-310*scale;
        var y_step=150*scale;
        var x_step=-155*scale*flip;
        var text_scale=scale*2;
		var furi_scale=text_scale*0.2;
		var furi_offset=160*furi_scale;
        var torifuda_remaining=torifuda_str;
		var character="";
		var xx,yy;
        for (var i=3;i>0;--i){
            var clip=string_copy(torifuda_remaining,1,5);
            torifuda_remaining=string_copy(torifuda_remaining,6,string_length(torifuda_remaining)-5);
            for (var j=0;j < 5;++j){
				character=string_char_at(clip,j+1);
				xx=x0+i*x_step-3*x_step;
				yy=y0+j*y_step;
				if (settings_furigana*settings_hide_all){
					draw_sprite_ext(sprite_small,0,xx,yy-furi_offset,text_scale*0.6,text_scale*0.6,0,c_white,alpha);
					draw_text_transformed(xx,yy-furi_offset,hiragana_to_romaji(character),-furi_scale*flip,furi_scale,0);
				}
                draw_text_transformed(xx,yy,character,-text_scale*flip,text_scale,0);
                if (--red_count == 0) draw_set_color(c_black);
            }
        }
    }
	if (abs(device_mouse_x_to_gui(0)-x)<270*scale)&&(abs(device_mouse_y_to_gui(0)-y)<430*scale)
		last_clicked=index;
}
function karuta_simple_draw(x,y,scale,index,alpha){
    //Get poem data
    var poem_name="poem_"+string(index);
    var poem_data=struct_get(poem_struct,poem_name);
    var red_str=poem_data.second_verse_answer;
    var red_count=string_length(red_str);
    var torifuda=poem_data.part2;
    var torifuda_str=remove_dakuten(torifuda);
    //Card flip
    var flip=1-flip_tween*2;
    var flipped=(flip_tween>0.5);
    draw_sprite_ext(sprite_card,flipped,x,y,scale*flip,scale,0,c_white,alpha);
    //Basic draw settings
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(font_hirigana_cursive);
    draw_set_alpha(alpha);
    //Draw number
    if (settings_number && flipped){
        var num_scale=scale*0.6;
        var num_y=y-418*scale;
        draw_set_color(c_white);
        draw_sprite_ext(sprite_circle,0,x,num_y,num_scale*flip,num_scale,0,c_white,alpha);
        draw_text_transformed(x,num_y,index,-num_scale*flip,num_scale,0);
    }
    //Text color for torifuda
    draw_set_color(c_black);
    draw_set_alpha(alpha);
    //Draw torifuda
    if (flipped){
        var x0=x-155*scale*flip;
        var y0=y-310*scale;
        var y_step=150*scale;
        var x_step=-155*scale*flip;
        var text_scale=scale*2;
        var torifuda_remaining=torifuda_str;
        for (var i=3;i>0;--i){
            var clip=string_copy(torifuda_remaining,1,5);
            torifuda_remaining=string_copy(torifuda_remaining,6,string_length(torifuda_remaining)-5);
            for (var j=0;j < 5;++j){
                draw_text_transformed(x0+i*x_step-3*x_step,y0+j*y_step,string_char_at(clip,j+1),-text_scale*flip,text_scale,0);
                if (--red_count == 0) draw_set_color(c_black);
            }
        }
    }
}
