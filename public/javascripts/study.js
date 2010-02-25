Studying = function(options) {
    var result = options;
    
    result.currentCard = null;
    
    result.loadCards = function() {
        $.getJSON(result.getCardsUrl, function(data) {
            $(result.spinnerDom).hide();
            result.setupQueue(data);
            result.studyNextCard();
        });
    };
    
    result.setupQueue = function(cards) {
        result.queue = new Queue();
        var i;
        for(i = 0; i < cards.length; i++) {
            result.queue.enqueue(cards[i]);
        }  
    };
    
    result.studyNextCard = function() {
        var card = result.queue.dequeue();
        
        $(result.cardDom).show();
        $(result.questionDom).hide();
        $(result.answerContainerDom).hide();
        
        if(card !== undefined) {
            result.currentCard = card;
            
            $(result.questionDom).html(card.question);
            $(result.answerDom).html(card.answer);

            result.showQuestion();
        }
    };
    
    result.showQuestion = function() {
        $(result.questionDom).show();
    }
    
    result.showAnswer = function() {
        $(result.answerContainerDom).show();
    }
    
    result.processQualityOfRecall = function(quality_of_recall) {
        
    }
    
    return result;
}