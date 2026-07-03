import 'dart:convert';

import 'package:notemap/models/mindmap_node.dart';

class MindMapParserService {

  static MindMapNode parse(String jsonString) {

    final cleaned = jsonString
        .replaceAll("```json", "")
        .replaceAll("```", "")
        .trim();

    final Map<String, dynamic> data =
        jsonDecode(cleaned);

    return MindMapNode.fromJson(data);
  }
}