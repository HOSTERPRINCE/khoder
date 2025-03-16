import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khoder/components/myappbar.dart';
import 'package:khoder/problemservice/problemService.dart';

class AddProblem extends StatefulWidget {
  const AddProblem({super.key});

  @override
  State<AddProblem> createState() => _AddProblemState();
}

class _AddProblemState extends State<AddProblem> {
  final TextEditingController _problemDescriptionController = TextEditingController();
  final CodeController _codeController = CodeController(); // For code input
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final language=TextEditingController();
  final ProblemService problemService = ProblemService();

  @override
  void dispose() {
    _problemDescriptionController.dispose();
    _codeController.dispose();
    language.dispose();
    super.dispose();
  }

  void _submitProblem() {
    if (_formKey.currentState!.validate()) {
      String problemDescription = _problemDescriptionController.text;
      String problemCode = _codeController.text;
      problemService.addProblem(language.text, problemCode, problemDescription);


      _problemDescriptionController.clear();
      _codeController.clear();

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Problem submitted successfully!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Add Problem"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: language,
                  decoration: InputDecoration(
                    label: Text("Programming Language"),
                    labelStyle: GoogleFonts.orbitron(
                      color: Color(0xFFFF6B00),

                    ),
                    border: OutlineInputBorder(),
                  ),
                  style: GoogleFonts.orbitron(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.inversePrimary
                  ),
                ),
                SizedBox(height: 20,),
                // Problem Description Input
                TextFormField(
                  controller: _problemDescriptionController,
                  decoration: InputDecoration(
                    labelText: "Problem Description",
                    labelStyle: GoogleFonts.orbitron(
                      color: Color(0xFFFF6B00),
                    ),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a problem description.";
                    }
                    return null;
                  },
                  style: GoogleFonts.orbitron(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.inversePrimary
                  ),
                ),
                SizedBox(height: 20),

                // Problem Code Input
                Text(
                  "Problem Code",
                  style: GoogleFonts.orbitron(
                    fontSize: 18,
                    color: Color(0xFFFF6B00),

                  ),
                ),
                SizedBox(height: 8),

                // CodeField with Expanded
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: 300, // Set a fixed height for the Container
                  child: SingleChildScrollView(
                    child: CodeField(
                      controller: _codeController,
                      textStyle: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                      cursorColor: Theme.of(context).colorScheme.inversePrimary,
                      lineNumberStyle: LineNumberStyle(
                        textStyle: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      background: Theme.of(context).colorScheme.background,
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Submit Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      _submitProblem(); // Call the method here
                      Navigator.of(context).pop(); // Optionally, you can pop the context after submission
                    },
                    child: Text(
                      "Submit Problem",
                      style: GoogleFonts.orbitron(
                        fontSize: 20,
                        color: Color(0xFFFF6B00),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}