import 'package:cloud_firestore/cloud_firestore.dart';

class MyOrder {
  final CollectionReference myCartCollection =
  FirebaseFirestore.instance.collection('orders');

  MyOrder();

  /// Adds or updates an item in the cart
  Future<void> addToCart(
      {required String movieId,
        required String? uid,
        required String status,
        required String price,
        required String movie,
        required String createdBy,
        required String poster,
        }) async {
    try {
      DocumentReference docRef = await myCartCollection.add({
        'uid': uid,
        'movieId': movieId,
        'price': price,
        'status': status,
        'movie': movie,
        'createdBy': createdBy,
        'poster':poster,

      });

      print("ORDER data successfully updated in Firestore.");
    } catch (e) {
      print("Error updating cart data: $e");
      rethrow;
    }
  }
}
