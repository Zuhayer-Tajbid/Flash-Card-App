import 'package:flash_card/colors.dart';
import 'package:flash_card/database/database_helper.dart';
import 'package:flash_card/model/deck.dart';
import 'package:flash_card/model/fcard.dart';
import 'package:flash_card/screens/add_edit_card.dart';
import 'package:flash_card/widgets/add_edit_delete_card.dart';
import 'package:flash_card/widgets/emoji_button.dart';
import 'package:flash_card/widgets/flash_card.dart';
import 'package:flash_card/widgets/main_card_widget.dart';
import 'package:flash_card/widgets/review_card.dart';
import 'package:flutter/material.dart';
import 'package:flash_card/model/fcard.dart';

class CardScreen extends StatefulWidget {
  const CardScreen(
      {super.key,
      required this.deckId,
      required this.db,
      required this.deck,
      required this.onGetDeck});

  final void Function() onGetDeck;
  final DBHelper db;
  final int deckId;
  final Deck deck;

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  List<Fcard> allCard = [];
  int _selectedpageIndex = 0;
  TextEditingController qController = TextEditingController();
  TextEditingController aController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCard();
  }

  void getCard() async {
    List<Map<String, dynamic>> cardMap =
        await widget.db.getAllCards(deckID: widget.deckId);

    allCard = cardMap
        .map((map) => Fcard(
              deckId: map[DBHelper.DECK_ID],
              id: map[DBHelper.CARD_ID],
              question: map[DBHelper.CARD_QUESTION],
              answer: map[DBHelper.CARD_ANSWER],
              isDone: map[DBHelper.CARD_ISDONE],
              isForgotten: map[DBHelper.CARD_ISFORGOTTEN],
            ))
        .toList();
    if (allCard.isEmpty) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddEditCard(
              qController: qController,
              aController: aController,
              onAddCard: addCard,
              onUpdateCard: updateCard,
            ),
          ));
    }
    setState(() {});
  }

  void selectpage(int index) {
    setState(() {
      _selectedpageIndex = index;
    });
  }

//adding card to database
  void addCard() async {
    String question = qController.text;
    String answer = aController.text;
    if (question.isNotEmpty && answer.isNotEmpty) {
      Fcard card =
          Fcard(deckId: widget.deckId, question: question, answer: answer);
      bool check = await widget.db.addCard(card);
      if (check) {
        getCard();
        widget.onGetDeck();
        qController.clear();
        aController.clear();
      }
    }
  }

//updating card

  void updateCard(Fcard card) async {
    String question = qController.text;
    String answer = aController.text;
    if (question.isNotEmpty && answer.isNotEmpty) {
      Fcard ucard = Fcard(
          deckId: widget.deckId,
          id: card.id,
          question: question,
          answer: answer);
      bool check = await widget.db.updateCard(ucard);
      if (check) {
        getCard();
        widget.onGetDeck();
        qController.clear();
        aController.clear();
      }
    }
  }

//updating card done

  void updateDoneCard(Fcard card) async {
    bool check = await widget.db.updateCard(card);
    if (check) {
      getCard();
      widget.onGetDeck();
    }
  }

//deleting card
  void deleteCard(int id) async {
    bool check = await widget.db!.deleteCard(id);
    if (check) {
      getCard();
      widget.onGetDeck();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(milliseconds: 1500),
          backgroundColor: bodyCC,
          content: Text(
            'Card has been deleted',
            style: TextStyle(color: Colors.black),
          )));
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = MainCardWidget(
      allCard: allCard,
      aController: aController,
      qController: qController,
      onAddCard: addCard,
      onDeleteCard: deleteCard,
      onUpdateCard: updateCard,
      onDoneFunction: updateDoneCard,
      deckName: widget.deck.name,
    );
    var activePageTitle = widget.deck.name;

    List<Fcard> reviewCards =
        allCard.where((map) => map.isForgotten == 1).toList();

    if (_selectedpageIndex == 1) {
      activePage = ReviewCard(
        allCard: reviewCards,
        onDoneFunction: updateDoneCard,
        deckName: widget.deck.name,
      );
      activePageTitle = '${widget.deck.name} Review';
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bodyCC,
        centerTitle: true,
        title: Text(
          activePageTitle,
          style:
              TextStyle(fontFamily: 'cool', color: Colors.white, fontSize: 35),
        ),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
          onTap: selectpage,
          currentIndex: _selectedpageIndex,
          backgroundColor: bodyCC,
          elevation: 4,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            letterSpacing: 1.2,
          ),
          unselectedLabelStyle: TextStyle(fontSize: 12),
          selectedIconTheme: IconThemeData(size: 30),
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.menu_book_rounded,
                  color: Colors.white,
                ),
                label: 'Cards'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.refresh_rounded,
                  color: Colors.white,
                ),
                label: 'Review'),
          ]),
    );
  }
}
