import 'package:flash_card/colors.dart';
import 'package:flash_card/data/dummy_data.dart';
import 'package:flash_card/database/database_helper.dart';
import 'package:flash_card/model/deck.dart';
import 'package:flash_card/model/fcard.dart';
import 'package:flash_card/screens/card_screen.dart';
import 'package:flash_card/widgets/add_deck.dart';
import 'package:flash_card/widgets/alert_deck.dart';
import 'package:flash_card/widgets/deck_card.dart';
import 'package:flutter/material.dart';

class DeckScreen extends StatefulWidget {
  const DeckScreen({super.key});

  @override
  State<DeckScreen> createState() => _DeckScreenState();
}

class _DeckScreenState extends State<DeckScreen> {
  DBHelper? db;
  List<Deck> allDecks = [];
  List<int> doneCount = [];
  List<int> cardCount = [];
  final TextEditingController deckController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    db = DBHelper.getInstance;
    //db!.deleteDatabaseFile(); //for testing
    getDeck();
  }

//get all deck and card from database
  void getDeck() async {
    List<Map<String, dynamic>> deckMap = await db!.getAllDeckS();

    if (deckMap.isEmpty) {
      // Insert dummy deck
      await db!.addDeck(dummyDeck);

      // Insert dummy cards
      for (var card in dummyCards) {
        await db!.addCard(card);
      }

      // Fetch again
      deckMap = await db!.getAllDeckS();
    }

    allDecks = deckMap
        .map((map) =>
            Deck(id: map[DBHelper.DECK_ID], name: map[DBHelper.DECK_NAME]))
        .toList();

    doneCount.clear();
    cardCount.clear();

    for (var deck in allDecks) {
      List<Map<String, dynamic>> cards =
          await db!.getAllCards(deckID: deck.id!);
      int done = cards.where((card) => card[DBHelper.CARD_ISDONE] == 1).length;
      int cardLength = cards.length;
      doneCount.add(done);
      cardCount.add(cardLength);
    }

    setState(() {});
  }

// switch to card screen
  void toCardScreen(Deck deck) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CardScreen(
            deckId: deck.id!,
            db: db!,
            deck: deck,
            onGetDeck: getDeck,
          ),
        ));
  }

//add deck to database
  void addDeck() async {
    showDialog(
      context: context,
      builder: (context) => AlertDeck(
        deckController: deckController,
        db: db!,
        onGetDeck: getDeck,
      ),
    );
  }

//update deck
  void updateDeck(Deck deck) async {
    String previousText = deck.name;
    deckController.text = previousText;
    showDialog(
      context: context,
      builder: (context) => AlertDeck(
        deckController: deckController,
        db: db!,
        onGetDeck: getDeck,
        previousText: previousText,
        deckForUpdate: deck,
      ),
    );
  }

//delete deck from database
  void deleteDeck(int id) async {
    bool check = await db!.deleteDeck(id: id);
    if (check) {
      getDeck();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(milliseconds: 1500),
          backgroundColor: bodyC,
          content: Text(
            'Deck has been deleted',
            style: TextStyle(color: Colors.black),
          )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: backC,
        child: Container(
          margin: EdgeInsets.only(bottom: 55),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  "My Decks",
                  style: TextStyle(fontSize: 45, fontFamily: 'cool'),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: allDecks.length,
                  itemBuilder: (context, index) => DeckCard(
                    deck: allDecks[index],
                    onDoneCount: doneCount[index],
                    onTotalCount: cardCount[index],
                    onCardScreen: () {
                      toCardScreen(allDecks[index]);
                    },
                    onDeleteDeck: () {
                      deleteDeck(allDecks[index].id!);
                    },
                    onUpdateDeck: updateDeck,
                  ),
                ),
              ),
              AddDeck(onAddDeck: addDeck),
            ],
          ),
        ),
      ),
    );
  }
}
