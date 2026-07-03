import 'package:flutter/material.dart';

class MindMapNode {

  final String id;
  final String title;
  final List<MindMapNode> children;

  MindMapNode({
    required this.id,
    required this.title,
    required this.children,
  });

  factory MindMapNode.fromJson(Map<String, dynamic> json) {
    return MindMapNode(
      id: json["id"] ?? DateTime.now().microsecondsSinceEpoch.toString(),
      title: json["title"] ?? "",
      children: (json["children"] as List<dynamic>? ?? [])
          .map((child) => MindMapNode.fromJson(child))
          .toList(),
    );
  }
}