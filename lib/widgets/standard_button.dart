import 'package:flutter/material.dart';

class MStandardButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final bool isActive;

  const MStandardButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.red[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(32),
        shadowColor: Colors.black,
        elevation: 10,
        disabledBackgroundColor: Colors.grey[900],
      ),
      onPressed: isActive ? onPressed : null,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: isActive ? Colors.white : Colors.grey[400],
        ),
      ),
    );
  }
}
