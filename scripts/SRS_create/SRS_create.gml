function srs_create(){
	if !file_exists("srs_data.sav"){
		//The SRS data doesnt exist, so we make it
		ini_open("srs_data.sav");
		srs_system=ds_grid_create(5,100);
		var date_default=floor(date_current_datetime())-1;

		var ease_default=1;
		for (var i=0;i<100;++i) {
			//Define ID
		    srs_system[# 0,i]=i;//Index
			srs_system[# 1,i]=false;//Locked state
			srs_system[# 2,i]=date_default;//Last reviewed
			srs_system[# 3,i]=ease_default//Ease
			srs_system[# 4,i]=0;//Score
			ini_write_real(string(i),"index",srs_system[# 0,i]);
			ini_write_real(string(i),"locked",srs_system[# 1,i]);
			ini_write_real(string(i),"reviewed",srs_system[# 2,i]);
			ini_write_real(string(i),"easing",srs_system[# 3,i]);
			ini_write_real(string(i),"scoring",srs_system[# 4,i]);
		}
		ini_close();
	}
}