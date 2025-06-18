function srs_create(){
	srs_system=ds_grid_create(6,100);
	srs_sort=ds_grid_create(6,100);
	srs_alt_list=ds_list_create();
	if !file_exists("srs_data.sav"){
		//The SRS data doesnt exist, so we make it
		ini_open("srs_data.sav");
		var date_default=floor(date_current_datetime())-1;
		var ease_default=1;
		var string_index="";
		for (var i=0;i<100;++i) {
			//Define ID
		    srs_system[# 0,i]=i+1;//Index
			srs_system[# 1,i]=(i<5);//Locked state, 
			srs_system[# 2,i]=date_default;//Last reviewed
			srs_system[# 3,i]=ease_default//Ease
			srs_system[# 4,i]=(i<5)*100;//Score
			srs_system[# 5,i]=0;//Fading
			string_index=string(i+1);
			ini_write_real(string_index,"unlocked",srs_system[# 1,i]);
			ini_write_real(string_index,"reviewed",srs_system[# 2,i]);
			ini_write_real(string_index,"easing",srs_system[# 3,i]);
		}
		ini_close();
	}else{
		//File does exist, so load it
		ini_open("srs_data.sav");
		var string_index="";
		for (var i=0;i<100;++i) {
			//Define ID
			string_index=string(i+1);
		    srs_system[# 0,i]=i+1//Index
			srs_system[# 1,i]=ini_read_real(string_index,"unlocked",0);//Locked state
			srs_system[# 2,i]=ini_read_real(string_index,"reviewed",0);//Last reviewed
			srs_system[# 3,i]=ini_read_real(string_index,"easing",0);//Ease
			srs_score(i+1);
			srs_system[# 5,i]=0;//Fading
			ini_write_real(string_index,"scoring",srs_system[# 4,i]);
		}
		ini_close();
	}
	choose_poem=srs_select();
	srs_alt();
	choose_queue=false;
	audio_queue=false;
	flip_state=true;
	flip_tween=true;
	drop_value=0;
}
function srs_review(index,quality){
	var date_today=floor(date_current_datetime());
	var string_index=string(index);
	srs_system[# 2,index-1]=date_today;//Last reviewed
	srs_system[# 3,index-1]=clamp(srs_system[# 3,index-1]+0.1*(2.5-quality),0,3)//Ease
	srs_system[# 5,index-1]=8;//Session
	for (var i=0;i<100;++i){srs_system[# 5,i]=max(0,srs_system[# 5,i]-1);}
	srs_score(index);
	ini_open("srs_data.sav");
	ini_write_real(string_index,"reviewed",srs_system[# 2,index-1]);
	ini_write_real(string_index,"easing",srs_system[# 3,index-1]);
	ini_write_real(string_index,"scoring",srs_system[# 4,index-1]);
	ini_close();
}
function srs_score(index){
	var i=index-1;
	//Older reviewed cards score higher
	var date_reviewed=srs_system[# 2,i];
	var date_today=floor(date_current_datetime());
	var date_age=date_today-date_reviewed;
	//Harder cards are scored higher
	var easing=srs_system[# 3,i];//Ease score between 0 and 3, 3 being hardest
	//Calculate score
	var unlocked=srs_system[# 1,i];
	var fading=srs_system[# 5,i];
	var scoring=(10+date_age+easing*2)*unlocked;
	srs_system[# 4,i]=scoring;
}
function srs_select(){
	ds_grid_copy(srs_sort,srs_system);
	var mode=choose(0,1);
	switch (mode){
	    case 1:
	        //Prioritized based on age and ease
			for (var i=0;i<100;++i){
			    srs_sort[# 4,i]=clamp(srs_sort[# 4,i],0,8-srs_sort[# 5,i]);
			}
			ds_grid_sort(srs_sort,4,false);
			if (srs_sort[# 5,0]==0)return srs_sort[# 0,0];
	    case 0:
	        //True random
			var list=ds_list_create();
			for (var i=0;i<100;++i){if (srs_sort[# 1,i])ds_list_add(list,i+1);};
			ds_list_shuffle(list);
			return list[| 0];
	        break;
	}
	return 1;
}
function srs_alt(){
	ds_list_clear(srs_alt_list);
	for (var i=0;i<100;++i) {
	    if srs_system[# 1,i]ds_list_add(srs_alt_list,i+1);
	}
	ds_list_delete(srs_alt_list,ds_list_find_index(srs_alt_list,choose_poem));
	ds_list_shuffle(srs_alt_list)
	spread_4_poem[0]=srs_alt_list[| 0];
	spread_4_poem[1]=srs_alt_list[| 1];
	spread_4_poem[2]=srs_alt_list[| 2];
	spread_4_poem[3]=srs_alt_list[| 3];
	spread_4_poem[irandom(3)]=choose_poem;
	spread_9_poem[0]=srs_alt_list[| 0];
	spread_9_poem[1]=srs_alt_list[| 1];
	spread_9_poem[2]=srs_alt_list[| 2];
	spread_9_poem[3]=srs_alt_list[| 3];
	spread_9_poem[4]=srs_alt_list[| 4];
	spread_9_poem[5]=srs_alt_list[| 5];
	spread_9_poem[6]=srs_alt_list[| 6];
	spread_9_poem[7]=srs_alt_list[| 7];
	spread_9_poem[8]=srs_alt_list[| 8];
	spread_9_poem[irandom(8)]=choose_poem;
	alt_chosen=false;
}
/*
function grid_print(){
	var string_print="";
	for (var j=0;j<100;++j){
		for (var i=0;i<6;++i){
		    string_print+=string(srs_sort[# i,j])+"     ";
		}
		string_print+="\n";
	}
	clipboard_set_text(string_print)
}