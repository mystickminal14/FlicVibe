import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../database/auth.dart';

class DisplayMovie extends StatefulWidget {
  final String movieId;
  const DisplayMovie({super.key, required this.movieId});

  @override
  State<DisplayMovie> createState() => _DisplayMovieState();
}

class _DisplayMovieState extends State<DisplayMovie> {
  bool isLoading = true;
  Map<String, dynamic>? movieData;
  late YoutubePlayerController _youtubeController;
  bool _isFullScreen = false;
  bool _isControlsVisible = true;

  @override
  void initState() {
    super.initState();
    fetchMovieDetails();
    final videoId = YoutubePlayer.convertUrlToId(movieData?['link']);
    _youtubeController = YoutubePlayerController(
      initialVideoId: videoId ?? "",
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        controlsVisibleAtStart: true,
      ),
    );
  }

  Future<void> fetchMovieDetails() async {
    try {
      final data = await AuthService().getMovieById(widget.movieId);

      if (data.isNotEmpty) {
        setState(() {
          movieData = data[0]['movies'];
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching movie details: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load movie details")),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    if (_isFullScreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
    super.dispose();
  }

  void _toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
    });
    if (_isFullScreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
  }

  Widget _buildYouTubePlayer() {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _youtubeController,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
      ),
      builder: (context, player) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _isControlsVisible = !_isControlsVisible;
            });
          },
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              SizedBox(
                height: 300,
                child: player,
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: IconButton(
                  icon: Icon(
                    _isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
                    color: Colors.white,
                  ),
                  onPressed: _toggleFullScreen,
                ),
              ),
            ],
          ),
        );
      },
    );
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
              Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: _buildYouTubePlayer(),
                ),
              ),
              const SizedBox(height: 20),
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
                  IconButton(
                    onPressed: () async {
                      final url = movieData?['link'];
                      if (url != null && await canLaunch(url)) {
                        await launch(url);
                      } else {
                        Navigator.pushNamed(context, '/login');
                      }
                    },
                    icon: const Icon(Icons.youtube_searched_for),
                  ),
                ],
              ),
              const SizedBox(height: 10),
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
              Wrap(
                spacing: 8,
                children: [
                  Chip(
                    label: Text(
                      movieData?['category'] ?? 'Unknown',
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    backgroundColor: Colors.grey[200],
                  ),
                ],
              ),
              const SizedBox(height: 20),
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

