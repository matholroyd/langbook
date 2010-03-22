Studying = function(options) {
    var that = options;
    
    that.currentCard = null;
    
    that.loadCards = function() {
        $.getJSON(that.getCardsUrl, function(data) {
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
        
        $(that.questionDom).hide();
        $(that.answerContainerDom).hide();
        
        that.updateStatus(that);
        
        if(card !== undefined) {
            $(that.cardDom).show();
            that.currentCard = card;
            
            $(that.questionDom).html(card.question_formatted);
            $(that.answerDom).html(card.answer_formatted);

            that.showQuestion();
        } else {
            $(that.cardDom).hide();
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
        $.put(that.putCardUrl, {id:that.currentCard.id, quality_of_recall:quality_of_recall}, function(data) {
            if(data['scheduled_to_recall?']) {
                that.queue.enqueue(that.currentCard);
            } 
            studying.studyNextCard();
        }, 'json');
    }
    
    that.cardsRemaining = function() {
        return that.queue.getSize() + 1;
    }
    
    return that;
}