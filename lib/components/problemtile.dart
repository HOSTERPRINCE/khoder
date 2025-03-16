import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for Clipboard
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:khoder/problemservice/problemService.dart';

class ProblemTile extends StatefulWidget {
  final String language;
  final String text;
  final String code;
  final String problemId;
  final bool ownerShip;
  final VoidCallback onDelete;
  final BuildContext parentContext;

  const ProblemTile({
    super.key,
    required this.language,
    required this.text,
    required this.code,
    required this.problemId,
    required this.ownerShip,
    required this.onDelete,
    required this.parentContext,
  });

  @override
  State<ProblemTile> createState() => _ProblemTileState();
}

class _ProblemTileState extends State<ProblemTile> {
  final ProblemService problemService = ProblemService();
  late Future<List<Map<String, dynamic>>> fetchCommentsFuture;
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchCommentsFuture = problemService.fetchComments(widget.problemId);
  }

  void _reloadComments() {
    setState(() {
      fetchCommentsFuture = problemService.fetchComments(widget.problemId);
    });
  }

  // Function to copy code to clipboard
  void _copyCodeToClipboard() {
    Clipboard.setData(ClipboardData(text: widget.code)).then((_) {
      ScaffoldMessenger.of(widget.parentContext).showSnackBar(
        SnackBar(
          content: Text("Code copied to clipboard!"),
          backgroundColor: Colors.green,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFFF6B00), width: 3.0),
      ),
      padding: EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.language,
                  style: GoogleFonts.orbitron(
                    fontSize: 20,
                    color: Color(0xFFFF6B00),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: _copyCodeToClipboard, // Copy code to clipboard
                      icon: Icon(
                        Icons.copy,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    if (widget.ownerShip)
                      IconButton(
                        onPressed: widget.onDelete,
                        icon: Icon(
                          Icons.delete,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              widget.text,
              style: GoogleFonts.orbitron(
                fontSize: 16,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  width: 2.0,
                ),
              ),
              child: Text(
                widget.code,
                style: GoogleFonts.orbitron(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: widget.parentContext,
                  isScrollControlled: true,
                  backgroundColor: Theme.of(context).colorScheme.background,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  builder: (parentContext) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: FutureBuilder(
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
                                              style: GoogleFonts.orbitron(
                                                fontSize: 18,
                                                color: Color(0xFFFF6B00),
                                              ),
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
                                              await problemService.addComment(widget.problemId, userId, controller.text);
                                              Navigator.of(context).pop();
                                              controller.clear();
                                              ScaffoldMessenger.of(parentContext).showSnackBar(
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
                      },
                    );
                  },
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Give Solution",
                    style: GoogleFonts.orbitron(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(Icons.comment),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}