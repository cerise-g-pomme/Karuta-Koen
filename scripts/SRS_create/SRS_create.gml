///@function srs_card_create(_id)
///@desc Create a new SRS card struct
function srs_card_create(_id) {
    return {
        cardID: _id,
        unlocked: false,
		repetitions: 0,
		easeFactor: 2.5,
		interval: 1,
		lastReviewed: 0,
		dueDate: 0
    };
}
function srs_initialize(){
	//Load in all cards, or create the save
	if (!file_exists("srs_data.sav")){
		//The file does not exist, so we create it
		for (var i=1;i<=100;i++) {
		    var card=srs_card_create(i);
			card.unlocked=(i<=5);
		    srs_save_card(card);
		}
	}
	//The file does exist, so we load it
	srs_cards=ds_list_create();
	for (var i=1;i<=100;i++){
		var card=srs_load_card(i);
		if(card.unlocked)ds_list_add(srs_cards,card);
	}
	//Draw a starting card
	srs_draw_card();
}
function srs_draw_card(){
	ds_list_shuffle(srs_cards);
	var index=0;
	if (srs_cards[| index].cardID==choose_poem)index++;
	var card=srs_cards[| index];
	choose_poem=card.cardID;
}

function srs_get_next_card() {
    var best_card = undefined;
    var highest_priority = -1;
    var now = date_current_datetime();
	// Loop through cards
	for (var i=0; i<ds_list_size(srs_cards); i++) {
	    var card = srs_cards[| i];
    
	    if (card.unlocked && (card.cardID != choose_poem))&&(card.dueDate<now){
	        var overdue_seconds = now - card.dueDate;

	        // Only consider due cards
	        if (overdue_seconds >= 0) {
	            var age_score = overdue_seconds;
	            var difficulty_score = 3.5 - card.easeFactor;

	            // Final priority: weigh difficulty highly
	            var priority = age_score + difficulty_score * 86400;

	            // Update if this is higher than previous
	            if (priority > highest_priority) {
	                highest_priority = priority;
	                best_card = card;
	            }
	        }
	    }
	}
	if (best_card==undefined){
		ds_list_shuffle(srs_cards);
		var index=0;
		if (srs_cards[| index].cardID==choose_poem)index++;
		return srs_cards[| index];
	}
    return best_card;
}