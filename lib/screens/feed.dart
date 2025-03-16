import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khoder/components/myappbar.dart';
import 'package:khoder/components/problemtile.dart';
import 'package:khoder/problemservice/problemService.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final ProblemService problemService = ProblemService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "FEED"),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: RefreshIndicator(
                  onRefresh: () async {
                    setState(() {}); // Refresh UI manually
                  },
                  child: FutureBuilder(
                    future: problemService.fetchProblems(),
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
                            "No Problems Found",
                            style: GoogleFonts.orbitron(
                              fontSize: 20,
                              color: Color(0xFFFF6B00),
                            ),
                          ),
                        );
                      }
                      var problems = snapshot.data!;
                      return ListView.builder(
                        itemCount: problems.length,
                        itemBuilder: (context, index) {
                          var problem = problems[index];
                          return Column(
                            children: [
                              ProblemTile(
                                language: problem["language"],
                                text: problem["problemDescription"],
                                code: problem["problemCode"],
                                ownerShip: problem["userId"] == problemService.getCurrentUser()?.uid,
                                problemId: problem["problemId"],
                                onDelete: () async {
                                  await problemService.deleteProblem(problem["problemId"]); // Call deleteProblem
                                  setState(() {}); // Refresh UI after deletion
                                }, parentContext: context,
                              ),
                              SizedBox(height: 10,)
                            ],
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
      ),
    );
  }
}