import 'package:flash_card/model/deck.dart';
import 'package:flutter/material.dart';
import 'package:flash_card/colors.dart';

class DeckCard extends StatelessWidget {
  const DeckCard({
    super.key,
    required this.deck,
    required this.onDoneCount,
    required this.onTotalCount,
    required this.onCardScreen,
    required this.onDeleteDeck,
    required this.onUpdateDeck,
  });

  final Deck deck;
  final int onDoneCount;
  final int onTotalCount;
  final void Function() onCardScreen;
  final void Function() onDeleteDeck;
  final void Function(Deck deck) onUpdateDeck;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onCardScreen,
      child: Card(
        margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [bodyC, backC],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
              borderRadius: BorderRadius.circular(15)),
          height: 200,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    deck.name,
                    style: TextStyle(
                        fontSize: 35, color: Colors.black, fontFamily: 'quick'),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: LinearProgressIndicator(
                      value:
                          onTotalCount == 0 ? 0.0 : onDoneCount / onTotalCount,
                      minHeight: 20,
                      borderRadius: BorderRadius.circular(15),
                      color: bodyCC,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '$onDoneCount out of $onTotalCount completed',
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              ),
              Positioned(
                top: 8,
                left: 10,
                child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: bodyCC,
                    ),
                    child: IconButton(
                      onPressed: () {
                        onUpdateDeck(deck);
                      },
                      icon: Icon(Icons.edit),
                      color: Colors.white,
                    )),
              ),
              Positioned(
                top: 8,
                right: 10,
                child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: IconButton(
                      onPressed: onDeleteDeck,
                      icon: Icon(Icons.delete),
                      color: bodyCC,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
