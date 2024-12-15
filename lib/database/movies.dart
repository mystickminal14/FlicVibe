import 'package:cloud_firestore/cloud_firestore.dart';

class MovieDatabaseService {
  final String createdBy;

  MovieDatabaseService({required this.createdBy});

  final CollectionReference MovieCollection =
  FirebaseFirestore.instance.collection('movies');

  Future<void> addMoviesData({
    required String img,
    required String vid,
    required String movie,
    required String desc,    required String price,
    required String category,

  }) async {
    try {
      DocumentReference docRef = await MovieCollection.add({
        'createdBy': createdBy,
        'poster': img,
        'vid': vid,
        'desc': desc,
        'price': price,
        'movie': movie,
        'category':category
      });

      print("Movie added successfully with ID: ${docRef.id}");
    } catch (e) {
      print("Error adding Movie data: $e");
      rethrow;
    }
  }

  Future<void> updateMoviesData({
    required String createdBy,
    required String img,
    required String MovieName,
    required String brandName,
    required String life,
    required String volume,
    required String category,
    required String type,
    required String origin,
    required String price,
    required String stock,
    required String desc,
    required Map<String, dynamic> reviews,
  }) async {
    try {
      await MovieCollection.doc(createdBy).set({
        'createdBy': createdBy,
        'MovieName': MovieName,
        'brandName': brandName,
        'life': life,
        'volume': volume,
        'img': img,
        'category': category,
        'type': type,
        'origin': origin,
        'price': price,
        'stock': stock,
        'desc': desc,
        'reviews': reviews,
      }, SetOptions(merge: true));

      print("Movie updated successfully in Firestore.");
    } catch (e) {
      print("Error updating Movie data: $e");
      rethrow;
    }
  }
}
