import 'dart:convert';
import 'dart:typed_data';


import 'package:flick/database/auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../database/user.dart';

class CustomAppHead extends StatefulWidget {
  final String title;
  const CustomAppHead({super.key, required this.title});

  @override
  State<CustomAppHead> createState() => _CustomAppHeadState();
}

class _CustomAppHeadState extends State<CustomAppHead> {

  bool isLoadingUser = true;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final user = Provider.of<UserModel?>(context, listen: false);
      if (user != null) {
        final data = await AuthService().getCust(user.uid);
        setState(() {
          userData = data.isNotEmpty ? data[0]['user'] : null;
        });
      }
    } catch (e) {
      print("Error fetching user data: $e");
    } finally {
      setState(() {
        isLoadingUser = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final base64Image = userData?['image'] ?? '';

    Uint8List? imageBytes;
    if (base64Image.isNotEmpty) {
      try {
        imageBytes = base64Decode(base64Image);
      } catch (e) {
        print("Error decoding Base64: $e");
        imageBytes = null;
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 20, vertical: 14),


      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CircleAvatar(
                foregroundImage: imageBytes != null
                    ? MemoryImage(imageBytes)
                    : const AssetImage('assets/visa.png'),
                maxRadius: 18,
              ),

              Text(
                widget.title,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
              ),
              const SizedBox(
                width: 18,
              ),

            ],
          ),
        ],
      ),
    );
  }
}
