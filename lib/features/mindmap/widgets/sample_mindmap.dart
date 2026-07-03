// import 'package:notemap/features/mindmap/widgets/mindmap_node.dart';

// import '../models/mindmap_node.dart';

import 'package:notemap/models/mindmap_node.dart';

final sampleMindMap = MindMapNode(
  id: "root",
  title: "AI Mind Map App",
  children: [

    MindMapNode(
      id: "1",
      title: "Frontend",
      children: [

        MindMapNode(
          id: "1.1",
          title: "Flutter UI",
          children: [],
        ),

        MindMapNode(
          id: "1.2",
          title: "Animations",
          children: [],
        ),
      ],
    ),

    MindMapNode(
      id: "2",
      title: "Backend",
      children: [

        MindMapNode(
          id: "2.1",
          title: "Gemini AI",
          children: [],
        ),

        MindMapNode(
          id: "2.2",
          title: "Mind Map JSON",
          children: [],
        ),
      ],
    ),
  ],
);