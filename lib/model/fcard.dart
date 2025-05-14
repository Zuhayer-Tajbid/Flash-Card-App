class Fcard {

const Fcard({required this.deckId,required this.question,required this.answer,this.id,this.isForgotten=0,this.isDone=0});

final int deckId;
final int ?id;
final int isForgotten;
final String question;
final String answer;
final int? isDone;
}