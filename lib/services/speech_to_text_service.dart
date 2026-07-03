import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextService {
  final SpeechToText _speech = SpeechToText();

  bool get isAvailable => _speech.isAvailable;
  bool get isListening => _speech.isListening;

  Future<bool> init() async {
    return await _speech.initialize(
      onError: (error) {
        print("Speech error: $error");
      },
      onStatus: (status) {
        print("Speech status: $status");
      },
    );
  }

  Future<void> start({
    required Function(String text) onResult,
  }) async {
    await _speech.listen(
      listenMode: ListenMode.dictation,
      partialResults: true,
      onResult: (result) {
        onResult(result.recognizedWords);
      },
    );
  }

  Future<void> stop() async {
    await _speech.stop();
  }
}