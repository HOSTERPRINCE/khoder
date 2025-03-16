import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khoder/suggestionservice/suggestionservice.dart';

class SuggestionTile extends StatefulWidget {
  final String suggestion;
  final bool ownerShip;
  final int commentCount;
  final String suggestionId;
  final BuildContext suggestionContext;

  const SuggestionTile({
    super.key,
    required this.suggestion,
    required this.ownerShip,
    required this.commentCount,
    required this.suggestionContext,
    required this.suggestionId,
  });

  @override
  State<SuggestionTile> createState() => _SuggestionTileState();
}

class _SuggestionTileState extends State<SuggestionTile> {
  final SuggestionService suggestionService = SuggestionService();
  final TextEditingController controller = TextEditingController();

  late Future<List<Map<String, dynamic>>> fetchCommentsFuture;

  @override
  void initState() {
    super.initState();
    fetchCommentsFuture = suggestionService.fetchComments(widget.suggestionId);
  }

  void _reloadComments() {
    setState(() {
      fetchCommentsFuture = suggestionService.fetchComments(widget.suggestionId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFFFF6B00), width: 2.0),
                ),
                padding: EdgeInsets.all(8),
                child: Text(
                  widget.suggestion,
                  style: GoogleFonts.orbitron(
                    fontSize: 16,
                    color: Color(0xFFFF6B00),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 10),
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: widget.suggestionContext,
                            isScrollControlled: true,
                            backgroundColor: Theme.of(context).colorScheme.background,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                            ),
                            builder: (suggestionContext) {
                              return StatefulBuilder(builder: (context, setState) {
                                return SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.6,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Expanded(
                                          child: FutureBuilder<List<Map<String, dynamic>>>(
                                            future: fetchCommentsFuture,
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState == ConnectionState.waiting) {
                                                return Center(
                                                  child: CircularProgressIndicator(color: Color(0xFFFF6B00)),
                                                );
                                              }
                                              if (snapshot.hasError) {
                                                return Center(
                                                  child: Text(
                                                    "Error loading comments",
                                                    style: GoogleFonts.orbitron(
                                                      fontSize: 20,
                                                      color: Color(0xFFFF6B00),
                                                    ),
                                                  ),
                                                );
                                              }
                                              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                                return Center(
                                                  child: Text(
                                                    "No Comments Found",
                                                    style: GoogleFonts.orbitron(
                                                      fontSize: 20,
                                                      color: Color(0xFFFF6B00),
                                                    ),
                                                  ),
                                                );
                                              }

                                              var comments = snapshot.data!;
                                              return ListView.builder(
                                                itemCount: comments.length,
                                                itemBuilder: (context, index) {
                                                  var comment = comments[index];
                                                  return ListTile(
                                                    title: Text(
                                                      comment['comment'],
                                                      style: GoogleFonts.orbitron(fontSize: 18, color: Color(0xFFFF6B00)),
                                                    ),
                                                    subtitle: Text(
                                                      "By: ${comment['username']}",
                                                      style: GoogleFonts.roboto(
                                                        fontSize: 16,
                                                        color: Theme.of(context).colorScheme.inversePrimary,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            left: 20.0,
                                            right: 5,
                                            top: 10,
                                            bottom: MediaQuery.of(context).viewInsets.bottom,
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: TextField(
                                                  controller: controller,
                                                  style: GoogleFonts.roboto(
                                                    fontSize: 16,
                                                    color: Theme.of(context).colorScheme.inversePrimary,
                                                  ),
                                                  keyboardType: TextInputType.multiline,
                                                  decoration: InputDecoration(
                                                    hintText: "Add a comment...",
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
                                              IconButton(
                                                onPressed: () async {
                                                  if (controller.text.isNotEmpty) {
                                                    String userId = FirebaseAuth.instance.currentUser?.uid ?? "";
                                                    try {
                                                      await suggestionService.addComment(widget.suggestionId, userId, controller.text);
                                                      Navigator.of(context).pop();
                                                      controller.clear();
                                                      ScaffoldMessenger.of(suggestionContext).showSnackBar(
                                                        SnackBar(
                                                          content: Text("Comment successfully added.."),
                                                          backgroundColor: Colors.green,
                                                        ),
                                                      );
                                                      _reloadComments();

                                                    } catch (e) {
                                                      print("Error adding comment: $e");
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                        SnackBar(
                                                          content: Text("Failed to add comment. Please try again."),
                                                          backgroundColor: Colors.red,
                                                        ),
                                                      );
                                                    }
                                                  }
                                                },
                                                icon: Icon(Icons.send, color: Color(0xFFFF6B00)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                            },
                          );
                        },
                        icon: Icon(Icons.comment, color: Theme.of(context).colorScheme.inversePrimary),
                      ),
                      SizedBox(width: 2),
                      Text("${widget.commentCount}"),
                    ],
                  ),
                  if (widget.ownerShip)
                    IconButton(
                      onPressed: () {
                        suggestionService.deleteSuggestion(widget.suggestionId);
                      },
                      icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}