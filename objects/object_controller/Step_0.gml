flip_tween=flip_tween*0.8+flip_state*0.2;
if mouse_check_button_released(mb_left)&&!flip_state{
	flip_state=true;
}
if (choose_queue&(flip_tween<0.5)){
	choose_poem=irandom_range(1,100);
	choose_queue=false;
	audio_queue=true;
}

if keyboard_check_released(vk_space){
	if (flip_state){
		
		
	}else{
		
		
	}
}