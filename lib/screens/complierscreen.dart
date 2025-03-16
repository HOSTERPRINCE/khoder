import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart'; // For Clipboard
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:highlight/languages/dart.dart';
import 'package:highlight/languages/python.dart';
import 'package:highlight/languages/java.dart';
import 'package:highlight/languages/javascript.dart';
import 'package:highlight/languages/cpp.dart';
import 'package:highlight/languages/kotlin.dart';
import 'package:khoder/components/myappbar.dart';

class CompilerScreen extends StatefulWidget {
  @override
  _CompilerScreenState createState() => _CompilerScreenState();
}

class _CompilerScreenState extends State<CompilerScreen> {
  final CompilerService _compilerService = CompilerService();
  late CodeController _codeController;
  String _output = "";
  String _selectedLanguage = "python"; // Default language

  // Map for language icons
  final Map<String, String> _languageIcons = {
    'python': "lib/python.png",
    'javascript': "lib/js.png",
    'java': "lib/java.png",
    'cpp': "lib/cpp.png",
    'kotlin': "lib/code.png",
    'dart': "lib/code.png",
  };

  @override
  void initState() {
    super.initState();
    _codeController = CodeController(
      text: '', // Initial code
      language: python, // Default language
    );
  }

  void _compileCode() async {
    String code = _codeController.text.trim();

    if (code.isEmpty) {
      setState(() {
        _output = "Please enter some code.";
      });
      return;
    }

    setState(() {
      _output = "Compiling...";
    });

    String result = await _compilerService.compileCode(_selectedLanguage, code);

    setState(() {
      _output = result;
    });
  }

  void _updateLanguage(String language) {
    setState(() {
      _selectedLanguage = language;
      switch (language) {
        case "python":
          _codeController.language = python;
          break;
        case "javascript":
          _codeController.language = javascript;
          break;
        case "java":
          _codeController.language = java;
          break;
        case "cpp":
          _codeController.language = cpp;
          break;
        case "kotlin":
          _codeController.language = kotlin;
          break;
        case "dart":
          _codeController.language = dart;
          break;
        default:
          _codeController.language = python;
      }
    });
  }

  void _copyCode() {
    Clipboard.setData(ClipboardData(text: _codeController.text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Code copied to clipboard!"),
        backgroundColor: Colors.green,
      ),
    );
  }

  // Paste code from clipboard
  void _pasteCode() async {
    ClipboardData? data = await Clipboard.getData('text/plain');
    if (data != null && data.text != null) {
      setState(() {
        _codeController.text = data.text!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Complier"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dropdown for language selection with icons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: _selectedLanguage,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      _updateLanguage(newValue);
                    }
                  },
                  items: _languageIcons.entries.map<DropdownMenuItem<String>>(
                        (MapEntry<String, String> entry) {
                      return DropdownMenuItem<String>(
                        value: entry.key,
                        child: Row(
                          children: [
                            Image.asset(entry.value , height: 20,),
                            SizedBox(width: 8),
                            Text(entry.key , style: GoogleFonts.orbitron(
                              fontSize: 18,
                              color: Colors.orange
                            ),),
                          ],
                        ),
                      );
                    },
                  ).toList(),
                ),
                IconButton(
                  onPressed: _copyCode,
                  icon: Icon(Icons.copy, color: Colors.orange),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Code editor with syntax highlighting
            Expanded(
              child: CodeField(
                controller: _codeController,
                textStyle: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 18, // Increased font size
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
                cursorColor: Theme.of(context).colorScheme.inversePrimary, // Cursor color
                lineNumberStyle: LineNumberStyle(
                  textStyle: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary, // Line number color
                  ),
                ),
                background: Theme.of(context).colorScheme.background,
                expands: true,
              ),
            ),
            SizedBox(height: 16),
            // Buttons for Compile, Paste, and Copy
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _compileCode,
                  child: Text('Compile and Run' , style: GoogleFonts.orbitron(
                    color: Colors.orange,
                  ),),
                ),
                ElevatedButton(
                  onPressed: _pasteCode,
                  child: Text('Paste Code', style: GoogleFonts.orbitron(
                    color: Colors.orange,
                  ),),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Output section with Copy button
            Row(
              children: [
                Text(
                  'Output:',
                  style: GoogleFonts.orbitron(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Spacer(),
              ],
            ),
            SizedBox(height: 20,),
            Expanded(
              child: SingleChildScrollView(
                child: Container(

                  width: double.infinity,
                  child: HighlightView(
                    _output,
                    language: 'plaintext',
                    theme: monokaiSublimeTheme,
                    padding: EdgeInsets.all(12),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CompilerService {
  // Piston API endpoint
  static const String _apiUrl = "https://emkc.org/api/v2/piston/execute";

  // Method to compile and execute code
  Future<String> compileCode(String language, String code) async {
    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'language': language,
          'version': '*', // Use the latest version
          'files': [
            {
              'content': code,
            }
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['run']['output']; // Return the output
      } else {
        return "Error: ${response.statusCode} - ${response.body}";
      }
    } catch (e) {
      return "Error: $e";
    }
  }
}
