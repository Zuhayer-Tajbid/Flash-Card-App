import 'package:flash_card/model/deck.dart';
import 'package:flutter/material.dart';
import 'package:flash_card/database/database_helper.dart';

class AlertDeck extends StatelessWidget {
  const AlertDeck(
      {super.key,
      required this.deckController,
      required this.db,
      required this.onGetDeck,
      this.previousText,
      this.deckForUpdate});

  final void Function() onGetDeck;
  final DBHelper db;
  final TextEditingController deckController;
  final String? previousText;
  final Deck? deckForUpdate;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(previousText == null ? 'Add Deck' : 'Update Deck'),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: deckController,
          decoration: InputDecoration(
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              filled: true,
              fillColor: Colors.white,
              label: Text('Deck Name'),
              hintText: 'Enter deck name'),
          maxLength: 40,
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style:
                    TextStyle(color: const Color.fromARGB(255, 215, 119, 193)),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            ElevatedButton(
                onPressed: () async {
                  String name = deckController.text;

//add
                  if (previousText == null) {
                    if (name.isNotEmpty) {
                      Deck deck = Deck(name: name);
                      bool done = await db.addDeck(deck);
                      if (done) {
                        onGetDeck();
                      }
                      deckController.clear();
                      Navigator.pop(context);
                    }
                  }

//update
                  else {
                    if (name.isNotEmpty) {
                      Deck updatedDeck =
                          Deck(id: deckForUpdate!.id, name: name);
                      bool done = await db.updateDeck(updatedDeck);
                      if (done) {
                        onGetDeck();
                      }
                      deckController.clear();
                      Navigator.pop(context);
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 215, 119, 193),
                ),
                child: Text(
                  'Save',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
          ],
        )
      ],
    );
  }
}
