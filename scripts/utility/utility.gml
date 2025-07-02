function hiragana_to_romaji(hiragana_string) {
    var romaji_string = "";
    var i = 0;
    var length = string_length(hiragana_string);

    while (i < length) {
        var c = string_char_at(hiragana_string, i + 1);

        switch (c) {
            // Vowels
            case "あ": romaji_string += "a"; break;
            case "い": romaji_string += "i"; break;
            case "う": romaji_string += "u"; break;
            case "え": romaji_string += "e"; break;
            case "お": romaji_string += "o"; break;
			case "ゐ": romaji_string += "i"; break;
			case "ゑ": romaji_string += "e"; break;

            // K-group
            case "か": romaji_string += "ka"; break;
            case "き": romaji_string += "ki"; break;
            case "く": romaji_string += "ku"; break;
            case "け": romaji_string += "ke"; break;
            case "こ": romaji_string += "ko"; break;
			
            // G-group
            case "が": romaji_string += "ga"; break;
            case "ぎ": romaji_string += "gi"; break;
            case "ぐ": romaji_string += "gu"; break;
            case "げ": romaji_string += "ge"; break;
            case "ご": romaji_string += "go"; break;

            // S-group
            case "さ": romaji_string += "sa"; break;
            case "し": romaji_string += "shi"; break;
            case "す": romaji_string += "su"; break;
            case "せ": romaji_string += "se"; break;
            case "そ": romaji_string += "so"; break;
            // Z-group
            case "ざ": romaji_string += "za"; break;
            case "じ": romaji_string += "ji"; break;
            case "ず": romaji_string += "zu"; break;
            case "ぜ": romaji_string += "ze"; break;
            case "ぞ": romaji_string += "zo"; break;

            // T-group
            case "た": romaji_string += "ta"; break;
            case "ち": romaji_string += "chi"; break;
            case "つ": romaji_string += "tsu"; break;
            case "て": romaji_string += "te"; break;
            case "と": romaji_string += "to"; break;
            // D-group
            case "だ": romaji_string += "da"; break;
            case "ぢ": romaji_string += "ji"; break;
            case "づ": romaji_string += "zu"; break;
            case "で": romaji_string += "de"; break;
            case "ど": romaji_string += "do"; break;

            // N-group
            case "な": romaji_string += "na"; break;
            case "に": romaji_string += "ni"; break;
            case "ぬ": romaji_string += "nu"; break;
            case "ね": romaji_string += "ne"; break;
            case "の": romaji_string += "no"; break;

            // H-group
            case "は": romaji_string += "ha"; break;
            case "ひ": romaji_string += "hi"; break;
            case "ふ": romaji_string += "fu"; break;
            case "へ": romaji_string += "he"; break;
            case "ほ": romaji_string += "ho"; break;
            // B-group
            case "ば": romaji_string += "ba"; break;
            case "び": romaji_string += "bi"; break;
            case "ぶ": romaji_string += "bu"; break;
            case "べ": romaji_string += "be"; break;
            case "ぼ": romaji_string += "bo"; break;
            // P-group
            case "ぱ": romaji_string += "pa"; break;
            case "ぴ": romaji_string += "pi"; break;
            case "ぷ": romaji_string += "pu"; break;
            case "ぺ": romaji_string += "pe"; break;
            case "ぽ": romaji_string += "po"; break;

            // M-group
            case "ま": romaji_string += "ma"; break;
            case "み": romaji_string += "mi"; break;
            case "む": romaji_string += "mu"; break;
            case "め": romaji_string += "me"; break;
            case "も": romaji_string += "mo"; break;
			
            // Y-group
            case "や": romaji_string += "ya"; break;
            case "ゆ": romaji_string += "yu"; break;
            case "よ": romaji_string += "yo"; break;

            // R-group
            case "ら": romaji_string += "ra"; break;
            case "り": romaji_string += "ri"; break;
            case "る": romaji_string += "ru"; break;
            case "れ": romaji_string += "re"; break;
            case "ろ": romaji_string += "ro"; break;

            // W-group
            case "わ": romaji_string += "wa"; break;
            case "を": romaji_string += "wo"; break;

            // N
            case "ん": romaji_string += "n"; break;

            default: romaji_string += c; break;
        }

        i += 1;
    }
    return romaji_string;
}
/// @function struct_to_gml_code(s)
/// @param s - the struct to convert
/// @desc Returns a string of GML code that reconstructs the struct
/// @function struct_to_gml_code_pretty(s, indent)
/// @param s - the struct to convert
/// @param indent - current indent level
/// @desc Returns a string of GML code that reconstructs the struct, with pretty formatting
/// @desc Generate GML code to recreate a struct in memory
/// @param input_struct The struct to convert to GML code
/// @return A string with GML code that, when run, will recreate the struct

function generate_struct_code(input_struct) {
    var indent = "\t";
    var output = "poem_struct={\n";

    // Loop through each key in the struct
    var keys = variable_struct_get_names(input_struct);
    for (var i = 0; i < array_length(keys); i++) {
        var key = keys[i];
        var substruct = input_struct[? key];
        output += indent + key + ":{\n";

        // Get substruct keys
        var subkeys = variable_struct_get_names(substruct);
        for (var j = 0; j < array_length(subkeys); j++) {
            var subkey = subkeys[j];
            var value = substruct[? subkey];

            output += indent + indent + subkey + ": ";

            // Format based on value type
            if (is_string(value)) {
                output += "\"" + string(value) + "\"";
            } else if (is_real(value)) {
                output += string(value);
            } else {
                output += string(value);
            }

            // Add comma if not last item
            if (j != array_length(subkeys) - 1) {
                output += ",";
            }
            output += "\n";
        }

        output += indent + "}";

        // Add comma if not last item
        if (i != array_length(keys) - 1) {
            output += ",";
        }
        output += "\n";
    }

    output += "};\n";
    return output;
}
