Studying = function(options) {
    var that = options;
    
    that.currentCard = null;
    
    that.loadCards = function(path) {
        $.getJSON(path, function(data) {
            $(that.spinnerDom).hide();
            that.setupQueue(data);
            that.studyNextCard();
        });
    };
    
    that.setupQueue = function(cards) {
        that.queue = new Queue();
        var i;
        for(i = 0; i < cards.length; i++) {
            that.queue.enqueue(cards[i]);
        }  
    };
    
    that.studyNextCard = function() {
        var card = that.queue.dequeue();
        
        $(that.spinnerDom).hide();
        $(that.questionDom).hide();
        $(that.answerContainerDom).hide();
        
        that.updateStatus(that);
        
        if(card !== undefined) {
            $(that.cardDom).show();
            that.currentCard = card;
            
            $(that.questionDom).html(card.question_formatted);
            $(that.answerDom).html(card.answer_formatted);
            $(that.deckDom).html(card.deck.name);

            that.showQuestion();
        } else {
            $(that.cardDom).hide();
            $(that.finishedDom).show();
        }
    };
    
    that.showQuestion = function() {
        $(that.questionDom).show();
        $(that.showAnswerDom).show();
    }
    
    that.showAnswer = function() {
        $(that.showAnswerDom).hide();
        $(that.answerContainerDom).show();
    }
    
    that.processQualityOfRecall = function(quality_of_recall) {
        $(that.questionDom).hide();
        $(that.showAnswerDom).hide();
        $(that.spinnerDom).show();

        $.put(that.putCardUrl, {id:that.currentCard.id, quality_of_recall:quality_of_recall}, function(data) {
            
            if(data['scheduled_to_recall?']) {
                that.queue.enqueue(that.currentCard);
            } 
            studying.studyNextCard();
        }, 'json', false);
    }
    
    that.cardsRemaining = function() {
        return that.queue.getSize() + 1;
    }
    
    return that;
}