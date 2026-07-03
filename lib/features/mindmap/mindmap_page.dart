import 'package:flutter/material.dart';
import 'package:notemap/features/mindmap/widgets/sample_mindmap.dart';
import 'package:notemap/models/mindmap_node.dart';

// import 'data/sample_mindmap.dart';
import 'widgets/mindmap_canvas.dart';

class MindMapPage extends StatelessWidget {

  final MindMapNode root;

  const MindMapPage({
    super.key,
    required this.root,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        title: const Text("AI Mind Map"),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),

      body: MindMapCanvas(
        root: root,
      ),

    );
  }
}