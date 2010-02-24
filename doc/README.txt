How to build in Spaced Repetition support:

A user has many Flash cards.  Flash cards have a next repetition date, which is when that card should be repeated. Flash cards are sorted into decks. A user has many decks.

The system should remember what cards need to be recalled when a user first logs in.

The system has reference to many eBooks.


Study workflow (user experience):

1) Click 'start'
2) Next card to study appears, shows question
4) User clicks 'show answer'
3) User gives feedback
4) Go to 2 while more cards to show
5) Message saying "finished!"


Study workflow (server):
- Goals
  - Should be able to stop halfway through
  - Forgotten things should be added to back of pile

1) Starting page, no card loaded
2) Grab todays cards from server (ajax)
  3) Grab next card off list
  4) Display question, button to show answer
  5) Upon pressing show answer, answer is loaded, show quality of recall buttons
  6) Upon pressing of recall quality, send update to server, dispose or readd card to end depending on quality of recall
  7) Go back to 3 if more cards
8) Display 'finished' message