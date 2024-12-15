import 'dart:convert';
import 'dart:io';

import 'package:flick/database/auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../database/user.dart';

class AddMovie extends StatefulWidget {
  const AddMovie({super.key});

  @override
  State<AddMovie> createState() => _AddMovieState();
}

class _AddMovieState extends State<AddMovie> {
  File? _posterImage;
  File? _movieVideo;
  final picker = ImagePicker();
  bool setIsLoading = false;

  String movieName = '',
      description = '',
      category = '',
      _base64Poster = '',
      _videoPath = '',
      error = '',
  price='';

  final OutlineInputBorder border = const OutlineInputBorder(
    borderSide: BorderSide(width: 1.5, style: BorderStyle.solid, color: Colors.grey),
    borderRadius: BorderRadius.all(Radius.circular(5)),
  );

  // Dropdown categories
  final List<String> categories = ['Action', 'Romance', 'Horror'];
  String? selectedCategory;

  // Upload Movie Poster (Image)
  Future<void> uploadPoster() async {
    try {
      final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        final bytes = await pickedImage.readAsBytes();
        setState(() {
          _posterImage = File(pickedImage.path);
          _base64Poster = base64Encode(bytes);
          error = ''; // Clear error if any
        });
      } else {
        setState(() {
          error = "No poster selected";
        });
      }
    } catch (e) {
      setState(() {
        error = "Failed to pick poster: $e";
      });
    }
  }

  // Upload Movie Video
  Future<void> uploadVideo() async {
    try {
      final XFile? pickedVideo = await picker.pickVideo(source: ImageSource.gallery);
      if (pickedVideo != null) {
        setState(() {
          _movieVideo = File(pickedVideo.path);
          _videoPath = pickedVideo.path;
          error = ''; // Clear error if any
        });
      } else {
        setState(() {
          error = "No video selected";
        });
      }
    } catch (e) {
      setState(() {
        error = "Failed to pick video: $e";
      });
    }
  }

  // Reusable TextField Widget
  Widget textField(String label, Function(String) onChanged, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      style: const TextStyle(
        fontSize: 14,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w400,
      ),
      onChanged: (value) => setState(() => onChanged(value)),
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        focusedBorder: border,
        enabledBorder: border,
        labelStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  // Poster Upload Widget
  Widget _buildPosterUpload() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Upload Movie Poster",
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, fontFamily: "Poppins"),
        ),
        const SizedBox(height: 10),
        TextButton.icon(
          onPressed: uploadPoster,
          icon: const Icon(Icons.image),
          label: const Text('Upload Poster'),
        ),
        if (error.isNotEmpty && _posterImage == null)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(error, style: const TextStyle(color: Colors.red, fontSize: 12)),
          ),
      ],
    );
  }

  // Video Upload Widget
  Widget _buildVideoUpload() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Upload Movie Video",
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, fontFamily: "Poppins"),
        ),
        const SizedBox(height: 10),
        TextButton.icon(
          onPressed: uploadVideo,
          icon: const Icon(Icons.video_library),
          label: const Text('Upload Video'),
        ),
        if (error.isNotEmpty && _movieVideo == null)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(error, style: const TextStyle(color: Colors.red, fontSize: 12)),
          ),
      ],
    );
  }

  // Category Dropdown Widget
  Widget _buildCategoryDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select Category",
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, fontFamily: "Poppins"),
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            border: border,
            filled: true,
            fillColor: Colors.white,
          ),
          value: selectedCategory,
          hint: const Text("Choose a category"),
          items: categories.map((category) {
            return DropdownMenuItem(
              value: category,
              child: Text(category),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedCategory = value;
              error = '';
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return setIsLoading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
      appBar: AppBar(
        title: const Text('Add Movie'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPosterUpload(),
              const SizedBox(height: 20),
              _buildVideoUpload(),
              const SizedBox(height: 20),
              textField("Enter movie title", (value) => movieName = value),
              const SizedBox(height: 20),
              textField("Enter movie price", (value) => price = value),
              const SizedBox(height: 20),
              textField("Description", (value) => description = value, maxLines: 5),
              const SizedBox(height: 20),
              _buildCategoryDropdown(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final user = Provider.of<UserModel?>(context, listen: false);
                  if (movieName.isEmpty ||
                      _posterImage == null ||
                      _movieVideo == null ||
                      selectedCategory == null) {
                    setState(() {
                      error = "Please fill all fields and upload poster/video!";
                    });
                  } else {
                    setState(() {
                      error = '';
                      setIsLoading = true;
                    });
                    try {
                      await AuthService().addMovie(
                        context,
                        _base64Poster,
                        _videoPath,
                        movieName,
                        description,
                        user!.uid,
                        selectedCategory!,price
                      );
                      Navigator.pushNamed(context, "/HomePage");
                    } catch (e) {
                      setState(() {
                        error = "Error adding movie: $e";
                      });
                    } finally {
                      setState(() {
                        setIsLoading = false;
                      });
                    }
                  }
                },
                child: const Text("Save Movie"),
              ),
              if (error.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(error, style: const TextStyle(color: Colors.red, fontSize: 12)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
