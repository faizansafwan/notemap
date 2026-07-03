import 'package:flutter/material.dart';

class RecordInputBox extends StatelessWidget {

  final TextEditingController controller;
  final bool hasText;
  final VoidCallback onSend;

  const RecordInputBox({
    super.key,
    required this.controller,
    required this.hasText,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [

          // TEXT INPUT
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(18),
              ),

              child: TextField(
                controller: controller,
                maxLines: 5,
                minLines: 1,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Type your thoughts here...",
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // SEND BUTTON
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 58,
            width: 58,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.lightBlueAccent,
                ],
              ),
            ),

            child: IconButton(
              onPressed: hasText ? onSend : null,
              icon: const Icon(
                Icons.send_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}