import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:notemap/models/mindmap_node.dart';

// import '../models/mindmap_node.dart';
import 'mindmap_node_card.dart';

class MindMapCanvas extends StatefulWidget {

  final MindMapNode root;

  const MindMapCanvas({
    super.key,
    required this.root,
  });

  @override
  State<MindMapCanvas> createState() => _MindMapCanvasState();
}

class _MindMapCanvasState extends State<MindMapCanvas> {

  final Graph graph = Graph();

  final BuchheimWalkerConfiguration builder =
      BuchheimWalkerConfiguration();

  @override
  void initState() {
    super.initState();

    _buildGraph(widget.root);

    builder
      ..siblingSeparation = 35
      ..levelSeparation = 55
      ..subtreeSeparation = 45
      ..orientation = BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM;
  }

  void _buildGraph(MindMapNode root) {

    final rootNode = Node.Id(root.id);

    graph.addNode(rootNode);
    _addChildren(rootNode, root);
  }

  void _addChildren(Node parentNode, MindMapNode parentData) {

    graph.addNode(parentNode);

    for (final child in parentData.children) {

      final childNode = Node.Id(child.id);

      graph.addEdge(parentNode, childNode);

      _addChildren(childNode, child);
    }
  }

  Widget _buildNodeWidget(String id, MindMapNode data) {

    final nodeMap = <String, MindMapNode>{};

    void traverse(MindMapNode node) {
      nodeMap[node.id] = node;

      for (final child in node.children) {
        traverse(child);
      }
    }

    traverse(widget.root);

    final node = nodeMap[id];

    return MindMapNodeCard(
      title: node?.title ?? "",
    );
  }

  @override
Widget build(BuildContext context) {

  return LayoutBuilder(
    builder: (context, constraints) {

      return InteractiveViewer(
        constrained: false,

        boundaryMargin: const EdgeInsets.all(1000),

        minScale: 0.1,
        maxScale: 5.0,

        panEnabled: true,
        scaleEnabled: true,

        child: SizedBox(
          width: constraints.maxWidth,
          height: constraints.maxHeight,

          child: Center(
            child: GraphView(
              graph: graph,

              algorithm: BuchheimWalkerAlgorithm(
                builder,
                TreeEdgeRenderer(builder),
              ),

              paint: Paint()
                ..color = Colors.deepPurple
                ..strokeWidth = 2
                ..style = PaintingStyle.stroke,

              builder: (Node node) {

                final id = node.key!.value as String;

                return _buildNodeWidget(id, widget.root);
              },
            ),
          ),
        ),
      );
    },
  );
}
}