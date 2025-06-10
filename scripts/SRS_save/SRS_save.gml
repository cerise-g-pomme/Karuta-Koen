///@function srs_save_card(_card, _ini_file)
function srs_save_card(_card) {
    ini_open("srs_data.sav");
    var section = "card_" + string(_card.cardID);
    ini_write_real(section, "unlocked", _card.unlocked);
    ini_write_real(section, "easeFactor", _card.easeFactor);
    ini_write_real(section, "interval", _card.interval);
    ini_write_real(section, "lastReviewed", _card.lastReviewed);
    ini_write_real(section, "dueDate", _card.dueDate);
    ini_close();
}
///@function srs_load_card(_id, _ini_file)
function srs_load_card(_id) {
    ini_open("srs_data.sav");
    var section = "card_" + string(_id);
    var _card = srs_card_create(_id);
    if (ini_key_exists(section, "unlocked")) {
        _card.unlocked = ini_read_real(section, "unlocked", false);
        _card.easeFactor = ini_read_real(section, "easeFactor", 2.5);
        _card.interval = ini_read_real(section, "interval", 1);
        _card.lastReviewed = ini_read_real(section, "lastReviewed", 0);
        _card.dueDate = ini_read_real(section, "dueDate", 0);
    }
    ini_close();
    return _card;
}
///@function srs_is_due(_card)
///@desc Check if the card is due for review
function srs_is_due(_card) {
    var now = date_current_datetime();
    return _card.unlocked && date_compare(_card.dueDate, now) <= 0;
}