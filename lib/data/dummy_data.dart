import 'package:flash_card/model/deck.dart';
import 'package:flash_card/model/fcard.dart';

// Dummy Deck
Deck dummyDeck = Deck(
  id: 1, // Fixed ID for dummy deck
  name: 'Flutter Basics',
);

// Dummy Cards
List<Fcard> dummyCards = [
 Fcard(
    deckId: 1,
    question: 'What is a StatelessWidget?',
    answer: 'A widget that does not require mutable state.',
  ),
  Fcard(
    deckId: 1,
    question: 'What is a StatefulWidget?',
    answer: 'A widget that can rebuild itself when its state changes.',
  ),
  Fcard(
    deckId: 1,
    question: 'What is the build() method?',
    answer: 'A method that describes the part of the UI represented by the widget.',
    isDone: 1,
  ),
  Fcard(
    deckId: 1,
    question: 'What is the purpose of MaterialApp?',
    answer: 'It wraps a number of widgets that are commonly required for Material Design applications.',
  ),
  Fcard(
    deckId: 1,
    question: 'What is initState() used for?',
    answer: 'It is called once when the stateful widget is inserted in the widget tree.',
    isForgotten: 1,
  ),
  Fcard(
    deckId: 1,
    question: 'What is the difference between Navigator.push and Navigator.pop?',
    answer: 'push adds a new screen on top, pop removes the current one.',
  ),
  Fcard(
    deckId: 1,
    question: 'What does the “hot reload” feature do?',
    answer: 'It allows code changes to be injected into a running app without restarting it.',
  ),
];

