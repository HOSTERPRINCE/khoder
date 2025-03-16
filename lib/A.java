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