import 'package:cflash/core/utility/toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CardStatistics {
  final String userId;

  CardStatistics({required this.userId});

  Future<int> getTotalCards() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Cards')
          .where('uid', isEqualTo: userId)
          .get();

      return querySnapshot.size;
    } catch (e) {
      Utility().toastMessage('Error fetching total cards: $e');
      return 0;
    }
  }

  Future<int> getTotalSubjects() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Subject')
          .where('uid', isEqualTo: userId)
          .get();

      return querySnapshot.size;
    } catch (e) {
      Utility().toastMessage('Error fetching total subjects: $e');
      return 0;
    }
  }

  Future<int> getTotalFavorites() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Cards')
          .where('uid', isEqualTo: userId)
          .where('favorite', isEqualTo: "yes")
          .get();

      return querySnapshot.size;
    } catch (e) {
      Utility().toastMessage('Error fetching total favorites: $e');
      return 0;
    }
  }
}