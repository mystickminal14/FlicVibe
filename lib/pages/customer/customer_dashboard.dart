import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flick/pages/customer/CustomAppHeader.dart';
import 'package:flick/pages/customer/view_movies.dart';
import 'package:flutter/material.dart';
import 'package:flick/database/auth.dart';

import '../ViewAdminMovie.dart';

class CustomerDashboard extends StatefulWidget {
  const CustomerDashboard({super.key});

  @override
  State<CustomerDashboard> createState() => _CustomerDashboardState();
}

class _CustomerDashboardState extends State<CustomerDashboard> with SingleTickerProviderStateMixin {
  bool isLoading = true;
  List<Map<String, dynamic>> movieData = [];
  List<Map<String, dynamic>> filteredMovieData = [];
  List<Map<String, dynamic>> horzontalMovies = [];
  final TextEditingController searchController = TextEditingController();
  Timer? _debounce;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    fetchMoviesByCategory('Action'); // Default tab: Action
    searchController.addListener(_filterMovies);
  }

  // Fetch movies by category
  Future<void> fetchMoviesByCategory(String category) async {
    setState(() {
      isLoading = true;
    });

    try {
      final fetchedMovies = await AuthService().getmovieByCategory(category);
      final horizontal = await AuthService().getMovies();

      setState(() {
        movieData = fetchedMovies;
        horzontalMovies=horizontal;
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

  // Debounced search function
  void _filterMovies() {
    final query = searchController.text.toLowerCase();

    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
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
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Column(
          children: [
            const CustomAppHead(title: 'Dashboard',),
            // Horizontal Movie List
            SizedBox(
              height: 200,
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : movieData.isEmpty
                  ? const Center(child: Text('No Movies Found'))
                  : _buildHorizontalList(),
            ),

            // Tab Bar
            TabBar(
              controller: _tabController,
              onTap: (index) {
                switch (index) {
                  case 0:
                    fetchMoviesByCategory('Action');
                    break;
                  case 1:
                    fetchMoviesByCategory('Romance');
                    break;
                  case 2:
                    fetchMoviesByCategory('Horror');
                    break;
                }
              },
              tabs: const [
                Tab(text: 'Action'),
                Tab(text: 'Romance'),
                Tab(text: 'Horror'),
              ],
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
            ),

            // Search Box
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: searchController,
                style: const TextStyle(
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  hintText: "Search Movies",
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'poppins',
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

            // Vertical Movie List
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : filteredMovieData.isEmpty
                  ? const Center(child: Text('No Movies Found'))
                  : _buildVerticalList(),
            ),
          ],
        ),
      ),
    );
  }

  // Horizontal Movie List
  Widget _buildHorizontalList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: horzontalMovies.length > 3 ? 3 : horzontalMovies.length,
      itemBuilder: (context, index) {
        final movie = horzontalMovies[index];
        final base64Image = movie['movies']['poster'] ?? '';
        Uint8List? imageBytes;

        if (base64Image.isNotEmpty) {
          try {
            imageBytes = base64Decode(base64Image);
          } catch (e) {
            print("Error decoding Base64: $e");
          }
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 130,
            child: Column(
              children: [
                Container(
                  height: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: imageBytes != null
                          ? MemoryImage(imageBytes)
                          : const AssetImage('assets/visa.png') as ImageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  movie['movies']['movie'] ?? 'Unknown Movie',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Vertical Movie List
  Widget _buildVerticalList() {
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
            onTap:(){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewMovies(movieId:  movie['movies']['id']),
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
                      image: AssetImage('assets/visa.png'),
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
