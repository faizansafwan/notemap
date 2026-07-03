import 'package:flutter/material.dart';

class MindMapNodeCard extends StatelessWidget {

  final String title;

  const MindMapNodeCard({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 14,
      ),
      constraints: const BoxConstraints(
        minWidth: 120,
        maxWidth: 220,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF6D5DF6),
            Color(0xFF8E7CFF),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 15,
          height: 1.4,
        ),
      ),
    );
  }
}