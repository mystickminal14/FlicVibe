import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flick/custom_widgets/custom_btn.dart';
import 'package:flutter/material.dart';
import 'package:flick/database/auth.dart';
import 'package:provider/provider.dart';

import '../../database/Order.dart';
import '../../database/order_db.dart';
import '../../database/user.dart';

class ViewMovies extends StatefulWidget {
  final String movieId;
  const ViewMovies({super.key, required this.movieId});

  @override
  State<ViewMovies> createState() => _ViewMoviesState();
}

class _ViewMoviesState extends State<ViewMovies> {
  bool isLoading = true;
  Map<String, dynamic>? movieData;
  Uint8List? imageBytes;

  @override
  void initState() {
    super.initState();
    fetchMovieDetails();
  }

  Future<void> fetchMovieDetails() async {
    try {
      final data = await AuthService().getMovieById(widget.movieId);

      if (data.isNotEmpty) {
        final base64Image = data[0]['movies']['poster'] ?? '';
        if (base64Image.isNotEmpty) {
          try {
            imageBytes = base64Decode(base64Image);
          } catch (e) {
            print("Error decoding Base64: $e");
          }
        }

        setState(() {
          movieData = data[0]['movies'];
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching movie details: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Details'),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : movieData == null
          ? const Center(child: Text('No Movie Data Available'))
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Movie Poster
              Center(
                child: Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: imageBytes != null
                          ? MemoryImage(imageBytes!)
                          : const AssetImage('assets/placeholder.png')
                      as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Movie Title
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Text(
                 movieData?['movie'] ?? 'Unknown Movie',
                 style: const TextStyle(
                   fontSize: 24,
                   fontWeight: FontWeight.bold,
                 ),
               ),
               CustomButton(text: 'Buy', onPressed: ()async {
    try {
    final user = Provider.of<UserModel?>(context, listen: false);
    final id =  movieData?['id'];
    final uid =  user?.uid;
    final movie =  movieData?['movie'];
    final price =   movieData?['price'];
    final createdBy =  movieData?['createdBy'];
    final image = movieData?['poster'];
await MyOrderController().addOrder(context: context, movieId: id, custId: uid??'', movie: movie, price: price, poster: image, status: 'ordered', createdBy: createdBy);
    Navigator.pushReplacementNamed(context, '/payment');
    } catch (e) {
    print("Error adding to cart: $e");
    ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Failed to add to cart')),
    );
    }
    })
             ],
           ),

              const SizedBox(height: 10),

              // Movie Rating and Duration
              Row(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.yellow),
                      const SizedBox(width: 5),
                      Text(
                        movieData?['rating']?.toStringAsFixed(1) ?? 'N/A',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Text(
                    movieData?['duration'] ?? 'N/A',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // Movie Genres
              Wrap(
                spacing: 8,
                children: (movieData?['genres'] as List<dynamic>? ?? [])
                    .map((genre) => Chip(
                  label: Text(
                    genre,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  backgroundColor: Colors.grey[200],
                ))
                    .toList(),
              ),

              const SizedBox(height: 20),

              // Movie Summary
              const Text(
                'Summary',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                movieData?['desc'] ?? 'No summary available.',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
