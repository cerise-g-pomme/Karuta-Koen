function main_initialize(){
	//Display settings
	display_reset(4,false);
	application_surface_enable(false);
	gpu_set_texfilter(true);
	gpu_set_tex_mip_enable(true);
	data_define();
	texturegroup_load("default");
	randomize();
	init_settings();
	button_color=c_white;
	//SRS settings
	srs_create();
	mode=0;
}
function main_draw(){
	//Draw the background
	draw_sprite_tiled_ext(sprite_tatami,0,0,0,1,1,c_white,0.02);
	//Switch modes
	button_color=546816;
	switch (mode) {
	    case 1://Memory SRS
			var center_x=window_get_width()*0.5;
			var center_y=window_get_height()*0.46;
			var scale=min(1,window_get_height()/1050);
			flip_tween=flip_tween*0.8+flip_state*0.2;
			karuta_ui(center_x,center_y,scale,choose_poem);
			var drop_smoothed=math_ease(clamp((1-drop_value)*1.2,0,1));
			drop_value=max(0,drop_value*0.8);
			if (drop_value>0.01)karuta_draw(center_x,center_y,scale,choose_old,1);
			karuta_draw(center_x+100*scale*drop_value,center_y-300*scale*drop_value,scale,choose_poem,drop_smoothed);
	        break;
	    default://Main menu
			var button_string;
			draw_set_font(font_hirigana);
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
			draw_set_color(c_white);
			var center_x=window_get_width()*0.5;
			var center_y=window_get_height()*0.35;
			var scale=min(1,window_get_height()/1050);
			var text_scale=scale*0.6;
			draw_sprite_ext(sprite_circle_1,0,center_x,center_y,scale,scale,0,c_white,1);
			var button_y=center_y+300*scale,button_o=90*scale;
			//Button
			if ui_button_sprite_draw(center_x,button_y,sprite_button_wide,scale){
				//Execute button
				mode=1;
			}
			button_string=["Memory Drills","記憶トレーニング"];
			draw_text_transformed(center_x,button_y,button_string[settings_language],text_scale,text_scale,0);button_y+=button_o;
			//Button
			if ui_button_sprite_draw(center_x,button_y,sprite_button_wide,scale){
				//Execute button
				var url="http://discord.gg/En84xCh6rE";
				url_open(url);
			}
			button_string=["Join Our Discord","ディスコード参加はこちら"];
			draw_text_transformed(center_x,button_y,button_string[settings_language],text_scale,text_scale,0);button_y+=button_o;
			//Button
			if ui_button_sprite_draw(center_x,button_y,sprite_button_wide,scale){
				//Execute button
				var url="https://www.paypal.com/donate/?business=AYQRKKJ8G33TC&no_recurring=0&item_name=Development+of+the+Karuta+K%C5%8Den+learning+app%2C+and+further+supporting+the+Portland+Karuta+community.&currency_code=USD";
				url_open(url);
			}
			button_string=["Support Development","サポート開発"];
			draw_text_transformed(center_x,button_y,button_string[settings_language],text_scale,text_scale,0);button_y+=button_o;
		    //Option buttons
			button_color=546816;
		    var right_button_scale=scale*0.6;
		    bx=window_get_width()-100*right_button_scale;
		    by=100*right_button_scale;
		    var step=130*right_button_scale;
			//Draw the buttons
		    if (ui_button_sprite_draw(bx,by,sprite_button_language,right_button_scale)){ settings_language=!settings_language;mouse_clear(mb_left);save_settings();} by+=step;
	        break;
	}



	
	

}