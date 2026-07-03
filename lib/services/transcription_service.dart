class TranscriptionService {

  static Future<String> transcribeAudio(String path) async {

    // LATER:
    // Upload audio to Whisper API

    await Future.delayed(const Duration(seconds: 2));

    return """
Today I worked on the NoteMap AI project.
Built the record page.
Implemented reusable Flutter widgets.
Integrated Gemini AI.
Need to work on mind map generation next.
""";
  }
}