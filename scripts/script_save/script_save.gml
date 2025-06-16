function init_settings(){
	//Define settings
	settings_dakuten=true;
	settings_number=true;
	settings_handwrite=true;
	settings_flip=false;
	settings_mark=true;
	settings_poem=true;
	settings_red=true;
	settings_syllable=true;
	settings_beginner=true;
	settings_romaji=true;
	settings_autoplay=true;
	settings_language=0;
	settings_furigana=false;
	load_settings();
}
function save_settings(){
	ini_open("settings.sav");
	ini_write_real("setting","number",settings_number);
	ini_write_real("setting","dakuten",settings_dakuten);
	ini_write_real("setting","handwriting",settings_handwrite);
	ini_write_real("setting","flipped",settings_flip);
	ini_write_real("setting","red_mark",settings_red);
	ini_write_real("setting","box_mark",settings_mark);
	ini_write_real("setting","beginner",settings_beginner);
	ini_write_real("setting","full_poem",settings_poem);
	ini_write_real("setting","first_syllables",settings_syllable);
	ini_write_real("setting","romanized_syllables",settings_romaji);
	ini_write_real("setting","autoplay",settings_autoplay);
	ini_write_real("setting","language",settings_language);
	ini_write_real("setting","furigana",settings_furigana);
	ini_close();
}
function load_settings(){
	if file_exists("settings.sav"){
	ini_open("settings.sav");
	settings_number=ini_read_real("setting","number",0);
	settings_dakuten=ini_read_real("setting","dakuten",0);
	settings_handwrite=ini_read_real("setting","handwriting",0);
	settings_flip=ini_read_real("setting","flipped",0);
	settings_red=ini_read_real("setting","red_mark",0);
	settings_mark=ini_read_real("setting","box_mark",0);
	settings_beginner=ini_read_real("setting","beginner",0);
	settings_poem=ini_read_real("setting","full_poem",0);
	settings_syllable=ini_read_real("setting","first_syllables",0);
	settings_romaji=ini_read_real("setting","romanized_syllables",0);
	settings_autoplay=ini_read_real("setting","autoplay",0);
	settings_language=ini_read_real("setting","language",0);
	settings_furigana=ini_read_real("setting","furigana",0);
	ini_close();
	}
}