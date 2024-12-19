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
    required String link,
    required String category,

  }) async {
    try {
      DocumentReference docRef = await MovieCollection.add({
        'createdBy': createdBy,
        'poster': img,
        'vid': vid,
        'desc': desc,
        'link':link,
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

}
