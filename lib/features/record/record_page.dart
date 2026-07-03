import 'package:flutter/material.dart';
import 'package:notemap/features/mindmap/mindmap_page.dart';
import 'package:notemap/features/record/widgets/ai_response_card.dart';
import 'package:notemap/features/record/widgets/record_input_box.dart';
import 'package:notemap/services/gemini_service.dart';
import 'package:notemap/services/mindmap_parser_service.dart';

// PHASE 2
// import 'package:notemap/services/speech_to_text_service.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {

  // PHASE 2
  // final SpeechToTextService speechService = SpeechToTextService();

  final TextEditingController controller = TextEditingController();

  bool hasText = false;
  bool isLoading = false;

  // PHASE 2
  // bool isRecording = false;

  String aiResponse = "";

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      setState(() {
        hasText = controller.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> sendPrompt() async {
    if (controller.text.trim().isEmpty) return;

    setState(() {
      isLoading = true;
      aiResponse = "";
    });

    final prompt = """
You are an AI that converts unstructured thoughts into structured JSON for a mind map application.

RULES:
- Return ONLY valid JSON
- No markdown
- No explanation text
- No triple backticks
- Keep the structure clean and hierarchical
- Each node must contain:
  - id
  - title
  - children

JSON FORMAT:
{
  "title": "Main Topic",
  "children": [
    {
      "id": "1",
      "title": "Topic",
      "children": []
    }
  ]
}

Convert this text into a hierarchical mind map JSON structure.

TEXT:
${controller.text}
""";

    final response = await GeminiService.generateText(prompt);

    if (response != null) {

      final rootNode = MindMapParserService.parse(response);

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MindMapPage(
            root: rootNode,
          ),
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  // =========================================================
  // PHASE 2 - SPEECH TO TEXT IMPLEMENTATION
  // =========================================================

  /*
  Future<void> toggleRecording() async {

    if (!isRecording) {

      final available = await speechService.init();

      if (!available) {
        debugPrint("Speech recognition not available");
        return;
      }

      setState(() {
        isRecording = true;
      });

      await speechService.start(
        onResult: (text) {
          setState(() {
            controller.text = text;

            controller.selection = TextSelection.fromPosition(
              TextPosition(offset: controller.text.length),
            );

            hasText = text.trim().isNotEmpty;
          });
        },
      );

    } else {

      await speechService.stop();

      setState(() {
        isRecording = false;
      });
    }
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: const Text("Record Thoughts"),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),

      body: SafeArea(
        child: Column(
          children: [

            // MAIN CONTENT
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [

                    // HERO SECTION
                    if (aiResponse.isEmpty && !isLoading)
                      Container(
                        margin: const EdgeInsets.only(top: 40),
                        child: Column(
                          children: [

                            Container(
                              width: 120,
                              height: 120,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.deepPurple,
                                    Colors.purpleAccent,
                                  ],
                                ),
                              ),
                              child: Icon(
                                hasText ? Icons.send : Icons.edit_note,
                                size: 50,
                                color: Colors.white,
                              ),
                            ),

                            const SizedBox(height: 25),

                            Text(
                              hasText
                                  ? "Ready to structure your thoughts"
                                  : "Type your ideas",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 10),

                            const Text(
                              "Your thoughts will automatically become structured content",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(height: 40),

                    if (isLoading)
                      const Padding(
                        padding: EdgeInsets.all(20),
                        child: CircularProgressIndicator(),
                      ),

                    if (aiResponse.isNotEmpty)
                      AIResponseCard(response: aiResponse),
                  ],
                ),
              ),
            ),

            // INPUT COMPONENT
            RecordInputBox(
              controller: controller,
              hasText: hasText,

              // PHASE 2
              // isRecording: isRecording,
              // onRecord: toggleRecording,

              onSend: sendPrompt,
            ),
          ],
        ),
      ),
    );
  }
}