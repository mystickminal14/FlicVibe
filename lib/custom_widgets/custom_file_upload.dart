import 'package:flutter/material.dart';

class CustomFileUpload extends StatefulWidget {
  final String label, labelText,upload;
  final double? height;
  final VoidCallback onPressed;

  const CustomFileUpload({
    super.key,
    required this.label,
    required this.onPressed,
    required this.labelText, required this.upload, required this.height,
  });

  @override
  State<CustomFileUpload> createState() => _CustomFileUploadState();
}

class _CustomFileUploadState extends State<CustomFileUpload> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontFamily: 'poppins',
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          widget.labelText,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 5),
        OutlinedButton.icon(
          onPressed: widget.onPressed,
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.black,
            minimumSize: const Size(double.infinity, 50),
            backgroundColor: Colors.white,
            fixedSize: Size(double.infinity, widget.height as double),
            side: const BorderSide(
              color: Colors.black,
              width: 1.5,
              style: BorderStyle.solid,
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
          icon: const Icon(
            Icons.add_a_photo_outlined,
            color: Colors.black,
          ),
          label: Text(
            widget.upload,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
