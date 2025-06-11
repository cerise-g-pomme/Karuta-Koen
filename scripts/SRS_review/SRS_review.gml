///@function srs_review_card(_card, _rating)
///@desc Update card data based on review rating (0=fail, 1=hard, 2=good, 3=easy)
function srs_review_card(_card,_rating) {
	
	//Set the repetitions
	if (_card.repetitions==0)_card.interval=1;
	if (_card.repetitions==1)_card.interval=6;
	if (_card.repetitions>=2)_card.interval=round(_card.interval*_card.easeFactor);
	_card.repetitions=_card.repetitions+1;
	_card.easeFactor=_card.easeFactor+(0.1-(4-_rating)*0.08+(4-_rating)*0.02);
	//Incorrect
	if (_rating<3){
		_card.repetitions=0;
		_card.interval=1;
		_card.easeFactor=max(1.3,_card.easeFactor);
	}
	_card.lastReviewed=current_day;
	_card.dueDate=current_day+_card.interval;
    srs_save_card(_card);
}
