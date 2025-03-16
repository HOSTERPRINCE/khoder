import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khoder/components/myappbar.dart';
import 'package:khoder/suggestionservice/suggestionservice.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class AddSuggestion extends StatefulWidget {
  const AddSuggestion({super.key});

  @override
  State<AddSuggestion> createState() => _AddSuggestionState();
}

class _AddSuggestionState extends State<AddSuggestion> {

  final TextEditingController _controller = TextEditingController();
  late stt.SpeechToText _speech;
  bool _isListening = false;
  final SuggestionService suggestionService = SuggestionService();



  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) => print("Status: $status"),
        onError: (error) => print("Error: $error"),
      );

      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (result) {
            setState(() {
              _controller.text = result.recognizedWords;
              _controller.selection = TextSelection.fromPosition(
                TextPosition(offset: _controller.text.length),
              );
            });
          },
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
  @override
  void dispose() {
    _controller.dispose();
    _speech.stop();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Add Problem"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 5, top: 10, bottom: 10),
                    child: TextField(
                      controller: _controller,
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: "Ask for suggestion",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0xFFFF6B00), width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.deepOrange, width: 3),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    onPressed: _listen,
                    icon: Icon(
                      _isListening ? Icons.mic : Icons.mic_none,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                ),

              ],
            ),
            SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("Ask any suggestions or questions related to coding , can also start a topic related to coding...", style: GoogleFonts.orbitron(
                fontSize: 18,
                color: Color(0xFFFF6B00),
              ),),
            ),
            SizedBox(height: 40,),
            GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
                suggestionService.addSuggestion(_controller.text);

              },
              child: Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).colorScheme.inversePrimary
                  ),
                  padding: EdgeInsets.all(16),
                  child:Text("Post", style: GoogleFonts.orbitron(
                    fontSize: 20,
                    color: Color(0xFFFF6B00),
                  ),)
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
