import 'dart:io';
import 'package:flash_card/model/deck.dart';
import 'package:flash_card/model/fcard.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {

  DBHelper._();

  static final DBHelper getInstance = DBHelper._();

  static final DECK_TABLE_TITLE = "deck";
  static final DECK_NAME = "deckNAME";
  static final DECK_ID = "deckId";
  static final CARD_TABLE_TITLE = "card";
  static final CARD_ID = "cardId";
  static final CARD_QUESTION = "question";
  static final CARD_ANSWER = "answer";
  static final CARD_ISFORGOTTEN = "isForgotten";
  static final CARD_ISDONE = "isDone";

  Database? myDB;


  Future<Database> getDB() async {
    if (myDB != null) {
      return myDB!;
    }

    myDB = await openDB();
    return myDB!;
  }

//creating database
  Future<Database> openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();

    String appPath = join(appDir.path, "fcard.db");

    return await openDatabase(
      appPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
CREATE TABLE $DECK_TABLE_TITLE(
  $DECK_ID INTEGER PRIMARY KEY AUTOINCREMENT,
$DECK_NAME TEXT
)
''');

        await db.execute('''
CREATE TABLE $CARD_TABLE_TITLE(
  $CARD_ID INTEGER PRIMARY KEY AUTOINCREMENT,
  $DECK_ID INTEGER,
  $CARD_QUESTION TEXT,
  $CARD_ANSWER TEXT,
  $CARD_ISFORGOTTEN INTEGER,
  $CARD_ISDONE INTEGER
)

''');
      },
    );
  }

//adding deck
  Future<bool> addDeck(Deck deck) async {
    var db = await getDB();

    int rowsEffected = await db.insert(DECK_TABLE_TITLE, {
      DECK_NAME: deck.name,
    });

    return rowsEffected > 0;
  }

//adding card
  Future<bool> addCard(Fcard card) async {
    var db = await getDB();

    int rowsEffected = await db.insert(CARD_TABLE_TITLE, {
      DECK_ID: card.deckId,
      CARD_QUESTION: card.question,
      CARD_ANSWER: card.answer,
      CARD_ISFORGOTTEN: card.isForgotten,
      CARD_ISDONE: card.isDone,
    });

    return rowsEffected > 0;
  }

//fetching decks
  Future<List<Map<String, dynamic>>> getAllDeckS() async {
    var db = await getDB();
    return await db.query(DECK_TABLE_TITLE);
  }

//fetching cards
  Future<List<Map<String, dynamic>>> getAllCards({required int deckID}) async {
    var db = await getDB();
    return await db
        .query(CARD_TABLE_TITLE, where: '$DECK_ID = ?', whereArgs: [deckID]);
  }

//updating deck
  Future<bool> updateDeck(Deck deck) async {
    var db = await getDB();
    int rowsEffected = await db.update(
        DECK_TABLE_TITLE,
        {
          DECK_NAME: deck.name,
        },
        where: '$DECK_ID = ?',
        whereArgs: [deck.id]);
    return rowsEffected > 0;
  }

//updating card
  Future<bool> updateCard(Fcard card) async {
    var db = await getDB();
    int rowsEffected = await db.update(
        CARD_TABLE_TITLE,
        {
          CARD_QUESTION: card.question,
          CARD_ANSWER: card.answer,
          CARD_ISFORGOTTEN: card.isForgotten,
          CARD_ISDONE: card.isDone,

        },
        where: '$CARD_ID = ?',
        whereArgs: [card.id]);

    return rowsEffected > 0;
  }

//deleting deck
  Future<bool> deleteDeck( {required int id}) async {
    var db = await getDB();
    int rowsEffected = await db.delete(
      DECK_TABLE_TITLE,
      where: '$DECK_ID = ?',
      whereArgs: [id],
    );
    return rowsEffected > 0;
  }

//deleting card
  Future<bool> deleteCard(int id) async {
    var db = await getDB();
    int rowsEffected = await db.delete(
      CARD_TABLE_TITLE,
      where: '$CARD_ID = ?',
      whereArgs: [id],
    );
    return rowsEffected > 0;
  }

  //delete database
  Future<void> deleteDatabaseFile() async {
  Directory appDir = await getApplicationDocumentsDirectory();
  String appPath = join(appDir.path, "fcard.db");
  
  await deleteDatabase(appPath);

  print('Database deleted!');
}
}
