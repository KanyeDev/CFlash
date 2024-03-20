
import 'package:cflash/core/firebase_services/get_current_username.dart';
import 'package:cflash/core/utility/toast.dart';
import 'package:cflash/features/login/presentation/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utility/pageRoutes.dart';
import 'flashCard.dart';



class FlashcardService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addFlashcard(String subject, String userId, Flashcard flashcard) async {
    try {

      String id = DateTime.now().millisecondsSinceEpoch.toString();
      final CollectionReference addCards = FirebaseFirestore.instance.collection("Cards");

      await addCards.doc(id).set({
        'subject' : subject,
        'question': flashcard.question,
        'answer': flashcard.answer,
        'review': flashcard.review,
        'uid': userId,
        "flashCardId": id,
        "favorite": flashcard.favorite
      });
    } catch (e) {
      Utility().toastMessage("Error adding flashcard: $e");
    }
  }

  Future<void> rateFlashcard(String subject,String userId, String flashcardId, int rating) async {
    try {
      final DocumentSnapshot flashcardDoc = await _firestore.collection('Cards').doc(flashcardId).get();
      final int currentRating = (flashcardDoc.data() as Map<String, dynamic>?)?['review'] ?? 0;

      if (currentRating + rating >= 0) {
        // Update the review count of the flashcard
        await _firestore.collection('Cards').doc(flashcardId).update({
          'review': rating
        });
      }
      else{
        Utility().toastMessage("Review cant be less than '0'");
      }
    } catch (e) {
      Utility().toastMessage(e.toString());
    }
  }

  Stream<List<Flashcard>> getFlashcards(String subject, String userId) {
    return _firestore
        .collection('Cards')
        .where('uid', isEqualTo: userId)
        .where('subject', isEqualTo: subject)
        .orderBy('review') // Sort by review ascending
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data();
      return Flashcard(
        question: data['question'],
        answer: data['answer'],
        review: data['review'],
        flashCardId: data['flashCardId'],
        favorite: data['favorite'],
      );
    }).toList());
  }

  Stream<List<Flashcard>> getAllFlashcards(String userId) {
    return _firestore
        .collection('Cards')
        .where('uid', isEqualTo: userId)
        .orderBy('review') // Sort by review ascending
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data();
      return Flashcard(
        question: data['question'],
        answer: data['answer'],
        review: data['review'],
        flashCardId: data['flashCardId'],
        favorite: data['favorite'],
      );
    }).toList());
  }


  Future<void> deleteFlashcard(String userId, String flashCardId) async {
    try {
      final CollectionReference cardsCollection = FirebaseFirestore.instance.collection("Cards");

      await cardsCollection
          .doc(flashCardId) // Use the flashCardId to identify the document
          .delete();
    } catch (e) {
      Utility().toastMessage(e.toString());
    }
  }


  Future<void> deleteSubject(String subject, String currentUID) async {
    try {
      // Get reference to Firestore collection
      CollectionReference documents = FirebaseFirestore.instance.collection('Subject');

      // Query for the document to delete
      QuerySnapshot querySnapshot = await documents.where('title', isEqualTo: subject)
          .where('uid', isEqualTo: currentUID)
          .get();

      // Check if the document exists
      if (querySnapshot.size > 0) {
        // Delete the document
        querySnapshot.docs.first.reference.delete();
        Utility().toastMessage('Subject deleted successfully.');
      } else {
        Utility().toastMessage('Subject not found.');
      }
    } catch (e) {
      Utility().toastMessage('Error deleting document: $e');
    }
  }


  Stream<double> calculateCompletionProgress(String subject, String userId) async* {
    try {
      while (true) {
        final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('Cards')
            .where('uid', isEqualTo: userId)
            .where('subject', isEqualTo: subject)
            .get();

        final List<DocumentSnapshot> documents = querySnapshot.docs;
        int totalFlashcards = documents.length;
        int fiveStarReviews = 0;

        // Count the number of flashcards with a review equal to 5
        for (var doc in documents) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
          if (data != null) {
            int review = data['review'] ?? 0; // Use default value if review is null
            if (review == 5) {
              fiveStarReviews++;
            }
          }
        }

        // Calculate the completion progress percentage
        double completionPercentage = (fiveStarReviews / totalFlashcards);

        // Yield the completion progress
        yield completionPercentage;

        // Wait for a short duration before recalculating (optional)
        await Future.delayed(const Duration(seconds: 10)); // Adjust the duration as needed
      }
    } catch (e) {
      print("Error calculating completion progress: $e");
      yield 0.0; // Yield default value in case of error
    }
  }


  Stream<List<Flashcard>> getFlashcardsForUser(String userId){
    return FirebaseFirestore.instance
        .collection('Cards')
        .where('uid', isEqualTo: userId)
        .orderBy('review')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data();
      return Flashcard(
        question: data['question'],
        answer: data['answer'],
        review: data['review'],
        flashCardId: doc.id,
        favorite: data['favorite'],
      );
    }).toList());
  }

  Stream<List<Flashcard>> getFavouriteFlashcardsForUser(String userId){
    return FirebaseFirestore.instance
        .collection('Cards')
        .where('uid', isEqualTo: userId)
        .where("favorite",  isEqualTo: "yes")
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data();
      return Flashcard(
        question: data['question'],
        answer: data['answer'],
        review: data['review'],
        flashCardId: doc.id,
        favorite: data['favorite'],
      );
    }).toList());
  }

  Future<void> likeCard(String userId, String flashcardId, String like) async {
    try {
      final DocumentSnapshot flashcardDoc = await _firestore.collection('Cards').doc(flashcardId).get();

      if (like == "yes") {
        // Update the review count of the flashcard
        await _firestore.collection('Cards').doc(flashcardId).update({
          'favorite': "no"
        });
        Utility().toastMessage("Removed favourite");
      }
      else{
        // Update the review count of the flashcard
        await _firestore.collection('Cards').doc(flashcardId).update({
          'favorite': "yes"
        });
        Utility().toastMessage("Added to favourite");
      }
    } catch (e) {
      Utility().toastMessage(e.toString());
    }
  }

  Future<void> firebaseLogout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear(); // Clear stored email and password
      await auth.signOut();
    } catch (e) {
      Utility().toastMessage('Error logging out: $e');
      // Handle error
    }
  }

}
