function karuta_draw(x,y,scale,index,alpha){
	//Get poem data
	var poem_name="poem_"+string(index);
	var poem_data=struct_get(poem_struct,poem_name);
	var poem_red_string=poem_data.second_verse_answer;
	var poem_red_count=string_length(poem_red_string);
	var poem_kimaraji=poem_data.kimariji;
	var poem_kimaraji_count=string_length(poem_kimaraji);
	var torifuda=poem_data.part2;
	
	//Get poem name and index
	var new_torifuda=torifuda;
	if(settings_dakuten)new_torifuda=remove_dakuten(torifuda);

	//Card flip and draw
	var flip=1-flip_tween*2;
	var flipped=(flip_tween>0.5);
	draw_sprite_ext(sprite_card,flipped,x,y,scale*flip,scale,0,c_white,alpha);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_font(font_hirigana);
	draw_set_alpha(alpha);

	//Draw number if enabled
	if(settings_number&&flipped){
		draw_set_color(c_white);
		draw_sprite_ext(sprite_circle,0,x,y-418*scale,scale*0.6*flip,scale*0.6,0,c_white,alpha);
		draw_text_transformed(x,y-418*scale,index,-scale*0.3*flip,scale*0.3,0);
	}

	//Flip correction
	if(settings_flip)scale*=-1;


	//Draw the beginner kimaraji
	if (settings_beginner&&flipped){
		draw_set_color(c_red);
		draw_set_alpha(0.2*alpha);
		var kima_x_start=x;
		var kima_y_start=y-270*scale;
		var kima_x=kima_x_start;
		var kima_y=kima_y_start;
		var kima_o_x=-110*scale*flip;
		var kima_o_y=240*scale;
		if (poem_kimaraji_count>3)kima_x+=kima_o_x;
		var character;
		var count=0;
		var scale_kima=scale*3.6;
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
	draw_set_alpha(alpha);
	var count=poem_red_count;
	if (count&&settings_red)draw_set_color(c_red);
	var x0=x-155*scale*flip;
	var y0=y-310*scale;
	var y_step=150*scale;
	var x_step=-155*scale*flip;
	var text_scale=scale*2;
	var clip="";
	if(flipped){
		var torifuda_string=new_torifuda;
		for(var i=3;i>0;--i){
			clip=string_copy(torifuda_string,1,5);
			torifuda_string=string_copy(torifuda_string,6,string_length(torifuda_string)-5);
			for(var j=0;j<5;++j){
				draw_text_transformed(x0+i*x_step-x_step*3,y0+j*y_step,string_char_at(clip,j+1),-text_scale*flip,text_scale,0);
				count--;
				if (!count)draw_set_color(c_black);
	}}}

	//Draw mark
	if(flipped&&settings_mark)
		draw_sprite_ext(sprite_mark,poem_data.mark_n,x0+x_step*(poem_data.mark_x-3),y0+y_step*(poem_data.mark_y-1),-scale*flip,scale,0,c_white,alpha);
	if(settings_flip)scale*=-1;

}
