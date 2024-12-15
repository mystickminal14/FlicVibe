import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flick/database/auth.dart';
import 'package:flick/pages/customer/CustomAppHeader.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../database/user.dart';

class AdminAccount extends StatefulWidget {
  const AdminAccount({super.key});

  @override
  State<AdminAccount> createState() => _AdminAccountState();
}

class _AdminAccountState extends State<AdminAccount> {
  bool isLoadingbuyer = true;
  Map<String, dynamic>? buyerData;
  File? _image;
  String _base64Image = "";
  bool isLoading = false;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    fetchBuyerData();
  }

  Future<void> fetchBuyerData() async {
    try {
      final user = Provider.of<UserModel?>(context, listen: false);
      if (user == null || user.uid.isEmpty) {
        setState(() {
          isLoadingbuyer = false;
          buyerData = null;
        });
        return;
      }
      final data = await AuthService().getSellerByID(user.uid);
      setState(() {
        buyerData = data.isNotEmpty ? data[0]['user'] : null;
        isLoadingbuyer =
        false; // Ensure that the loading flag is set to false after fetching the data
      });
    } catch (e) {
      print("Error fetching buyer data: $e");
      setState(() {
        isLoadingbuyer = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final base64Image = buyerData?['image'] ?? '';
    Uint8List? imageBytes;

    if (base64Image.isNotEmpty) {
      try {
        imageBytes = base64Decode(base64Image);
      } catch (e) {
        print("Error decoding Base64: $e");
        imageBytes = null;
      }
    }

    return Scaffold(
      body: isLoadingbuyer
          ? const CircularProgressIndicator()// A loader component to show while data is being fetched
          : LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              const CustomAppHead(title: 'My Account'),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
                child: Row(
                  children: [
                    CircleAvatar(
                      foregroundImage: imageBytes != null
                          ? MemoryImage(imageBytes)
                          : const AssetImage('assets/visa.png'),
                      maxRadius: 38,
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          buyerData?['fullName'] ??
                              '',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'lovelo',
                              fontSize: 15),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          buyerData?['email'] ??
                              '',
                          style: TextStyle(
                            fontSize: constraints.maxWidth * 0.04,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [


                        const SizedBox(height: 20),

                        const SizedBox(height: 5),

                        _buildTiles(const Icon(Icons.logout,color: Colors.black,), 'Logout', () async {
                          await AuthService()
                              .userSignOut(context);
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildIconButton(
      IconData icon, String label, BoxConstraints constraints) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: constraints.maxWidth * 0.1, color: Colors.grey[800]),
        const SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: constraints.maxWidth * 0.03,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }

  Widget _buildTiles(Widget  icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: icon,
      title: Text(
        title,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'roboto',
            fontSize: 15),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black),
      onTap: onTap,
    );
  }
}
