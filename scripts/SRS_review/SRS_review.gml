///@function srs_review_card(_card, _rating)
///@desc Update card data based on review rating (0=fail, 1=hard, 2=good, 3=easy)
function srs_review_card(_card, _rating) {
    var now = date_current_datetime();
    // Mark as unlocked if not already
    if (!_card.unlocked) {
        _card.unlocked = true;
        _card.lastReviewed = now;
        _card.dueDate = date_add_day(now, _card.interval);
        srs_save_card(_card);
		return;
    }
    // Adjust ease factor (basic implementation of SM-2 algorithm)
    var ef = _card.easeFactor;
    if (_rating == 0) {
        _card.interval = 1;
    } else {
        ef += 0.1 - (3 - _rating) * (0.08 + (3 - _rating) * 0.02);
        if (ef < 1.3) ef = 1.3;
        _card.easeFactor = ef;
        if (_rating == 1) _card.interval = max(1, _card.interval * 1.2);
        else if (_rating == 2) _card.interval = max(1, _card.interval * ef);
        else if (_rating == 3) _card.interval = max(1, _card.interval * ef * 1.3);
    }
    // Update review times
    _card.lastReviewed = now;
    _card.dueDate = date_add_day(now, _card.interval);
    srs_save_card(_card);
}
