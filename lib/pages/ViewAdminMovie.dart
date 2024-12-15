import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flick/database/auth.dart';

class Viewadminmovie extends StatefulWidget {
  final String movieId;
  const Viewadminmovie({super.key, required this.movieId});

  @override
  State<Viewadminmovie> createState() => _ViewadminmovieState();
}

class _ViewadminmovieState extends State<Viewadminmovie> {
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
              Text(
                movieData?['movie'] ?? 'Unknown Movie',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
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
