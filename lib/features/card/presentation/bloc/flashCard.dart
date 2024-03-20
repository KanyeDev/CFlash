
class Flashcard {
  final String question;
  final String answer;
  final int review;
  final String flashCardId;
  final String favorite;

  Flashcard( {required this.question, required this.answer, required this.review, required this.flashCardId, required this.favorite});

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'answer': answer,
      'review': review,
      "flashCardId": flashCardId,
      "favorite": favorite
    };
  }
}
