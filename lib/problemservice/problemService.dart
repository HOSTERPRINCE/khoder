import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProblemService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<void> addProblem(String language, String problemCode, String problemDescription) async {
    try {
      String problemId = _fireStore.collection('problems').doc().id;
      String userId = _auth.currentUser?.uid ?? "";

      // Fetch the userName of the current user
      DocumentSnapshot userSnapshot = await _fireStore.collection('users').doc(userId).get();
      String userName = userSnapshot.exists ? userSnapshot['userName'] : "Unknown User"; // Use 'userName'

      await _fireStore.collection('problems').doc(problemId).set({
        'problemId': problemId,
        'language': language, // Use language instead of problemText
        'problemCode': problemCode, // Add problemCode
        'problemDescription': problemDescription, // Add problemDescription
        'userId': userId,
        'username': userName, // Add userName to the problem
        'comments': [],
        'commentCount': 0,
        'timestamp': FieldValue.serverTimestamp(),
      });
      print("Problem Added with ID: $problemId");
    } catch (e) {
      print("Failed to add problem: $e");
      throw Exception("Failed to add problem.");
    }
  }

  Future<void> addComment(String problemId, String userId, String commentText) async {
    try {
      DocumentReference problemRef = FirebaseFirestore.instance.collection('problems').doc(problemId);

      // Fetch the userName of the current user
      DocumentSnapshot userSnapshot = await _fireStore.collection('users').doc(userId).get();
      String userName = userSnapshot.exists ? userSnapshot['userName'] : "Unknown User"; // Use 'userName'

      // Add the comment to the comments array with the userName
      await problemRef.update({
        'comments': FieldValue.arrayUnion([
          {'userId': userId, 'username': userName, 'comment': commentText}
        ]),
        'commentCount': FieldValue.increment(1), // Increment comment count
      });

      print("Comment Added to Problem ID: $problemId");
    } catch (e) {
      print("Failed to add comment: $e");
      throw Exception("Failed to add comment.");
    }
  }

  Future<void> deleteComment(String problemId, String commentId) async {
    try {
      await _fireStore
          .collection('problems')
          .doc(problemId)
          .collection('comments')
          .doc(commentId)
          .delete();

      // Decrement comment count
      await _fireStore.collection('problems').doc(problemId).update({
        'commentCount': FieldValue.increment(-1),
      });

      print("Comment deleted from Problem ID: $problemId");
    } catch (e) {
      print("Failed to delete comment: $e");
      throw Exception("Failed to delete comment.");
    }
  }

  Future<void> deleteProblem(String problemId) async {
    try {
      await _fireStore.collection('problems').doc(problemId).delete();
      print("Problem deleted successfully: $problemId");
    } catch (e) {
      print("Failed to delete problem: $e");
      throw Exception("Failed to delete problem.");
    }
  }

  Future<bool> isUserOwner(String problemId) async {
    try {
      DocumentSnapshot snapshot = await _fireStore.collection('problems').doc(problemId).get();

      if (!snapshot.exists) {
        print("Problem not found!");
        return false;
      }

      String postOwnerId = snapshot['userId'];
      String currentUserId = _auth.currentUser!.uid;

      return postOwnerId == currentUserId;
    } catch (e) {
      print("Error checking ownership: $e");
      throw Exception("Failed to check ownership.");
    }
  }

  Future<List<Map<String, dynamic>>> fetchComments(String problemId) async {
    try {
      DocumentSnapshot problemSnapshot = await FirebaseFirestore.instance
          .collection('problems')
          .doc(problemId)
          .get();

      if (!problemSnapshot.exists) {
        print("Problem not found!");
        return [];
      }

      List<dynamic> comments = problemSnapshot['comments'] ?? [];
      if (comments.isEmpty) {
        print("No comments found in Firestore.");
        return [];
      }

      List<Map<String, dynamic>> commentList = [];
      for (var comment in comments) {
        commentList.add({
          'username': comment['username'] ?? "Unknown User", // Use the username from the comment
          'comment': comment['comment'],
        });
      }

      return commentList;
    } catch (e) {
      print("Error fetching comments: $e");
      throw Exception("Failed to fetch comments.");
    }
  }

  Future<List<Map<String, dynamic>>> fetchProblems() async {
    try {
      QuerySnapshot querySnapshot = await _fireStore
          .collection('problems')
          .orderBy('timestamp', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return {
          'problemId': doc.id,
          'language': data['language'], // Use language instead of problemText
          'problemCode': data['problemCode'], // Include problemCode
          'problemDescription': data['problemDescription'], // Include problemDescription
          'username': data['username'] ?? "Unknown User", // Include username in the problem
          'commentCount': data['commentCount'] ?? 0,
          'timestamp': data['timestamp'],
          'userId': data['userId'],
        };
      }).toList();
    } catch (e) {
      print("Error fetching problems: $e");
      throw Exception("Failed to fetch problems.");
    }
  }
}