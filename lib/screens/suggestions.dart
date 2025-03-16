import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khoder/components/myappbar.dart';
import 'package:khoder/components/suggestiontile.dart';
import 'package:khoder/suggestionservice/suggestionservice.dart';

class Suggestions extends StatefulWidget {
  const Suggestions({super.key});

  @override
  State<Suggestions> createState() => _SuggestionsState();
}

class _SuggestionsState extends State<Suggestions> {
  final SuggestionService suggestionService = SuggestionService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "SUGGESTIONS"),
      body: Column(
        children: [
          SizedBox(height: 50,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: RefreshIndicator(
                onRefresh: () async {
                  setState(() {}); // Refresh UI manually
                },
                child: FutureBuilder(
                  future: suggestionService.fetchSuggestions(),
                  builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(color: Color(0xFFFF6B00)),
                      );
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      print("Snapshot data: ${snapshot.data}");
                      return Center(
                        child: Text(
                          "No Suggestions found",
                          style: GoogleFonts.orbitron(
                            fontSize: 20,
                            color: Color(0xFFFF6B00),
                          ),
                        ),
                      );
                    }
                    var suggestions = snapshot.data!;
                    return ListView.builder(
                      itemCount: suggestions.length,
                      itemBuilder: (context, index) {
                        var suggestion = suggestions[index];
            
                        return SuggestionTile(
                          suggestion: suggestion["suggestion"],
                          ownerShip: suggestion["userId"] == suggestionService.getCurrentUser()?.uid,
                          commentCount: suggestion["commentCount"] ?? 0,
                          suggestionContext: context,
                          suggestionId: suggestion["suggestionId"],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
