function remove_dakuten(input) {
	input=string_replace_all(input,"が","か");
	input=string_replace_all(input,"ぎ","き");
	input=string_replace_all(input,"ぐ","く");
	input=string_replace_all(input,"げ","け");
	input=string_replace_all(input,"ご","こ");
	input=string_replace_all(input,"ざ","さ");
	input=string_replace_all(input,"じ","し");
	input=string_replace_all(input,"ず","す");
	input=string_replace_all(input,"ぜ","せ");
	input=string_replace_all(input,"ぞ","そ");
	input=string_replace_all(input,"だ","た");
	input=string_replace_all(input,"ぢ","ち");
	input=string_replace_all(input,"づ","つ");
	input=string_replace_all(input,"で","て");
	input=string_replace_all(input,"ど","と");
	input=string_replace_all(input,"ば","は");
	input=string_replace_all(input,"び","ひ");
	input=string_replace_all(input,"ぶ","ふ");
	input=string_replace_all(input,"べ","へ");
	input=string_replace_all(input,"ぼ","ほ");
	input=string_replace_all(input,"ぱ","は");
	input=string_replace_all(input,"ぴ","ひ");
	input=string_replace_all(input,"ぷ","ふ");
	input=string_replace_all(input,"ぺ","へ");
	input=string_replace_all(input,"ぽ","ほ");
    return input;
}