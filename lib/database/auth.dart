import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flick/database/movies.dart';
import 'package:flick/database/user.dart';
import 'package:flick/database/user_model.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel? _userFromFirebaseUser(User? user, Map<String, dynamic>? userData) {
    return userData != null
        ? UserModel(
            uid: user!.uid,
            email: userData['email'] ?? '',
            password: userData['password'] ?? '',
            role: userData['role'] ?? '',
          )
        : null;
  }

  Stream<UserModel?> get user {
    return _auth.authStateChanges().asyncMap((User? user) async {
      if (user == null) return null;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (!userDoc.exists) return null;
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      return _userFromFirebaseUser(user, userData);
    });
  }

  Future<String?> signUp(
    BuildContext context,
    String email,
    String password,
    String fullName,
    String role,
    String image,
  ) async {
    try {
      if (role != 'admin' && role != 'customer') {
        _showSnackBar(context, "Invalid role", Colors.red);
        return null;
      }

      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;

      await UserDatabase(uid: user!.uid).updateUserData(
        fullName: fullName,
        email: email,
        password: password,
        role: role,
        image: image,
      );

      _showSnackBar(context, "Registration successful", Colors.green);
      return "Registration successful";
    } catch (e) {
      _showSnackBar(context, "Registration failed: $e", Colors.red);
      return null;
    }
  }
  Future<List<Map<String, dynamic>>> getMovieById(String? id) async {
    try {
      final DocumentSnapshot vegSnapshot = await FirebaseFirestore.instance
          .collection('movies')
          .doc(id)
          .get();

      if (!vegSnapshot.exists) {
        return [];
      }

      final vegData = vegSnapshot.data() as Map<String, dynamic>;
      return [
        {
          'movies': {...vegData, 'id': vegSnapshot.id},
        }
      ];
    } catch (e) {
      throw Exception("Failed to fetch movie data: $e");
    }
  }
Future passwordReset(BuildContext context,email) async {
  try {
    await _auth.sendPasswordResetEmail(email: email.trim());
    _showSnackBar(context, "Email Verification sent successful", Colors.green);
  } catch (e) {
    _showSnackBar(context, "Email Dont exist", Colors.red);
  }
}
  Future<UserModel?> userLogIn(
      BuildContext context, String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;
      if (user == null) {
        _showSnackBar(context, "Login failed", Colors.red);
        return null;
      }

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (!userDoc.exists) {
        _showSnackBar(context, "Login failed", Colors.red);
        return null;
      }

      Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
      return _userFromFirebaseUser(user, data);
    } catch (e) {
      _showSnackBar(context, "Login failed: $e", Colors.red);
      return null;
    }
  }

  Future<Map<String, dynamic>?> getCurrentUser(
      BuildContext context, String uid) async {
    try {
      final DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (!userSnapshot.exists) {
        return null;
      }

      final data = userSnapshot.data() as Map<String, dynamic>;
      return {...data, 'id': userSnapshot.id};
    } catch (e) {
      _showSnackBar(context, "Failed to fetch user data: $e", Colors.red);
      return null;
    }
  }

  Future<void> addMovie(
    BuildContext context,
    String img,
    String vid,
    String movie,
    String desc,
    String? createdBy,
    String category,
      String price,
  ) async {
    try {
      MovieDatabaseService movieService =
          MovieDatabaseService(createdBy: createdBy!);
      await movieService.addMoviesData(
          img: img, vid: vid, movie: movie, desc: desc, category: category, price: price);

      _showSnackBar(context, "Movie uoloaded succesfully", Colors.green);
    } catch (e) {
      _showSnackBar(context, "Movie uoloaded un-succesfully", Colors.red);
    }
  }

  Future<List<Map<String, dynamic>>> getMovies() async {
    try {
      final QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('movies').get();

      if (querySnapshot.docs.isEmpty) {
        return [];
      }

      return querySnapshot.docs.map((doc) {
        final liquorData = doc.data() as Map<String, dynamic>;
        return {
          'movies': {...liquorData, 'id': doc.id}
        }; // Add the doc ID to the data
      }).toList();
    } catch (e) {
      throw Exception("Failed to fetch movie : $e");
    }
  }

  // Helper function to show a snackbar
  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 5),
        backgroundColor: color,
      ),
    );
  }
  Future<List<Map<String, dynamic>>> getCust(String uid) async {
    try {
      final QuerySnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where(FieldPath.documentId, isEqualTo: uid)
          .where('role', isEqualTo: 'customer')
          .get();

      if (userSnapshot.docs.isEmpty) {
        return [];
      }

      final data = userSnapshot.docs.first.data() as Map<String, dynamic>;
      return [
        {
          'user': {...data, 'id': userSnapshot.docs.first.id},
        }
      ];
    } catch (e) {
      throw Exception("Failed to fetch user data: $e");
    }
  }
  Future<List<Map<String, dynamic>>> getSellerByID(String uid) async {
    try {
      final QuerySnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where(FieldPath.documentId, isEqualTo: uid)
          .where('role', isEqualTo: 'admin')
          .get();

      if (userSnapshot.docs.isEmpty) {
        return [];
      }

      final data = userSnapshot.docs.first.data() as Map<String, dynamic>;
      return [
        {
          'user': {...data, 'id': userSnapshot.docs.first.id},
        }
      ];
    } catch (e) {
      throw Exception("Failed to fetch user data: $e");
    }
  }

  Future<List<Map<String, dynamic>>> getmovieByCategory(String category) async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('movies')
          .where('category', isEqualTo: category)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return [];
      }

      return querySnapshot.docs.map((doc) {
        final liquorData = doc.data() as Map<String, dynamic>;
        return {
          'movies': {...liquorData, 'id': doc.id}
        }; // Add the doc ID to the data
      }).toList();
    } catch (e) {
      throw Exception("Failed to fetch movie by category: $e");
    }
  }  Future<List<Map<String, dynamic>>> getMyMoviesSel(String uid) async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('orders')
          .where('createdBy', isEqualTo: uid)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return [];
      }

      return querySnapshot.docs.map((doc) {
        final liquorData = doc.data() as Map<String, dynamic>;
        return {
          'movies': {...liquorData, 'id': doc.id}
        }; // Add the doc ID to the data
      }).toList();
    } catch (e) {
      throw Exception("Failed to fetch movie by category: $e");
    }

  }
  Future<List<Map<String, dynamic>>> getMyMovies(String uid) async {
    try {
      final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('orders')
          .where('uid', isEqualTo: uid)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return [];
      }

      return querySnapshot.docs.map((doc) {
        final liquorData = doc.data() as Map<String, dynamic>;
        return {
          'movies': {...liquorData, 'id': doc.id}
        }; // Add the doc ID to the data
      }).toList();
    } catch (e) {
      throw Exception("Failed to fetch movie by category: $e");
    }

  }
  Future<void> userSignOut(BuildContext context) async {
    try {
      await _auth.signOut();
      Navigator.pushReplacementNamed(context, '/login');
      _showSnackBar(context, "Logout success!!", Colors.green);

    } catch (e) {
      _showSnackBar(context, "Error doing logout", Colors.red);

    }
  }
}

