/// @function date_add_day(_date, _days)
/// @desc Add days to a datetime and return the new datetime
/// @param _date The starting datetime (real)
/// @param _days Number of days to add (can be negative)
function date_add_day(_date, _days) {
    // One day in seconds
    var seconds_per_day = 86400;
    var added_seconds = _days * seconds_per_day;
    return _date + added_seconds;
}
/// @function date_compare(_date1, _date2)
/// @desc Compares two dates.
/// @param _date1 First datetime (real)
/// @param _date2 Second datetime (real)
/// @return -1 if _date1 < _date2, 0 if equal, 1 if _date1 > _date2
function date_compare(_date1, _date2) {
    if (_date1 < _date2) return -1;
    if (_date1 > _date2) return 1;
    return 0;
}