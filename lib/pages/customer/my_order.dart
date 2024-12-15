import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flick/custom_widgets/head.dart';
import 'package:flutter/material.dart';
import 'package:flick/database/auth.dart';
import 'package:provider/provider.dart';

import '../../database/user.dart';
import 'display_movie.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({super.key});

  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  bool isLoading = true;
  List<Map<String, dynamic>> movieData = [];
  List<Map<String, dynamic>> filteredMovieData = [];

  final TextEditingController searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    fetchMovies();
    searchController.addListener(_filterMovies);
  }

  Future<void> fetchMovies() async {
    final user = Provider.of<UserModel?>(context, listen: false);
    setState(() {
      isLoading = true;
    });

    try {
      final fetchedMovies = await AuthService().getMyMovies(user!.uid);

      setState(() {
        isLoading = false;
        movieData = fetchedMovies;
        filteredMovieData = fetchedMovies;
      });
    } catch (e) {
      print("Error fetching movies: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load movies. Please try again later.')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _filterMovies() {
    final query = searchController.text.toLowerCase();

    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        filteredMovieData = query.isEmpty
            ? movieData
            : movieData.where((movie) {
          final movieName = movie['movies']['movie']?.toLowerCase() ?? '';
          return movieName.contains(query);
        }).toList();
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const AppHeader(title: 'My Movies'),

            // Search Box
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: searchController,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  hintText: "Search Movies",
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.8,
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.8,
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Movie List
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : filteredMovieData.isEmpty
                  ? const Center(child: Text('No Movies Found'))
                  : _buildMovieList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieList() {
    return ListView.builder(
      itemCount: filteredMovieData.length,
      itemBuilder: (context, index) {
        final movie = filteredMovieData[index];
        final base64Image = movie['movies']['poster'] ?? '';
        Uint8List? imageBytes;

        if (base64Image.isNotEmpty) {
          try {
            imageBytes = base64Decode(base64Image);
          } catch (e) {
            print("Error decoding image: $e");
          }
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DisplayMovie(movieId: movie['movies']['movieId']),
                ),
              );
            },
            child: Card(
              elevation: 5,
              child: ListTile(
                leading: SizedBox(
                  width: 50,
                  height: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: imageBytes != null
                        ? Image.memory(imageBytes, fit: BoxFit.cover)
                        : const Image(
                      image: AssetImage('assets/placeholder.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Text(
                  movie['movies']['movie'] ?? 'Unknown Movie',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  movie['movies']['desc'] ?? 'No description available.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
