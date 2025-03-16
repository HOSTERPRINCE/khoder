import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SuggestionService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<void> addSuggestion(String suggestionText) async {
    try {
      String suggestionId = _fireStore.collection('suggestions').doc().id;
      String userId = _auth.currentUser?.uid ?? "";

      // Fetch the userName of the current user
      DocumentSnapshot userSnapshot = await _fireStore.collection('users').doc(userId).get();
      String userName = userSnapshot.exists ? userSnapshot['userName'] : "Unknown User"; // Use 'userName'

      await _fireStore.collection('suggestions').doc(suggestionId).set({
        'suggestionId': suggestionId,
        'suggestion': suggestionText,
        'userId': userId,
        'username': userName, // Add userName to the suggestion
        'comments': [],
        'likes': [],
        'likeCount': 0,
        'commentCount': 0,
        'timestamp': FieldValue.serverTimestamp(),
      });
      print("Suggestion Added with ID: $suggestionId");
    } catch (e) {
      print("Failed to add suggestion: $e");
      throw Exception("Failed to add suggestion.");
    }
  }

  Future<void> toggleLike(String suggestionId, String userId) async {
    try {
      DocumentReference suggestionRef = FirebaseFirestore.instance.collection('suggestions').doc(suggestionId);
      DocumentSnapshot suggestionSnapshot = await suggestionRef.get();

      if (suggestionSnapshot.exists) {
        List<dynamic> likes = suggestionSnapshot['likes'] ?? [];

        if (likes.contains(userId)) {
          // Unlike: Remove user from likes array and decrement likeCount
          await suggestionRef.update({
            'likes': FieldValue.arrayRemove([userId]),
            'likeCount': FieldValue.increment(-1),
          });
          print("User $userId unliked Suggestion ID: $suggestionId");
        } else {
          // Like: Add user to likes array and increment likeCount
          await suggestionRef.update({
            'likes': FieldValue.arrayUnion([userId]),
            'likeCount': FieldValue.increment(1),
          });
          print("User $userId liked Suggestion ID: $suggestionId");
        }
      }
    } catch (e) {
      print("Error toggling like: $e");
      throw Exception("Failed to toggle like.");
    }
  }

  Future<void> addComment(String suggestionId, String userId, String commentText) async {
    try {
      DocumentReference suggestionRef = FirebaseFirestore.instance.collection('suggestions').doc(suggestionId);

      // Fetch the userName of the current user
      DocumentSnapshot userSnapshot = await _fireStore.collection('users').doc(userId).get();
      String userName = userSnapshot.exists ? userSnapshot['userName'] : "Unknown User"; // Use 'userName'

      // Add the comment to the comments array with the userName
      await suggestionRef.update({
        'comments': FieldValue.arrayUnion([
          {'userId': userId, 'username': userName, 'comment': commentText}
        ]),
        'commentCount': FieldValue.increment(1), // Increment comment count
      });

      print("Comment Added to Suggestion ID: $suggestionId");
    } catch (e) {
      print("Failed to add comment: $e");
      throw Exception("Failed to add comment.");
    }
  }

  Future<void> deleteComment(String suggestionId, String commentId) async {
    try {
      await _fireStore
          .collection('suggestions')
          .doc(suggestionId)
          .collection('comments')
          .doc(commentId)
          .delete();

      // Decrement comment count
      await _fireStore.collection('suggestions').doc(suggestionId).update({
        'commentCount': FieldValue.increment(-1),
      });

      print("Comment deleted from Suggestion ID: $suggestionId");
    } catch (e) {
      print("Failed to delete comment: $e");
      throw Exception("Failed to delete comment.");
    }
  }

  Future<void> deleteSuggestion(String suggestionId) async {
    try {
      await _fireStore.collection('suggestions').doc(suggestionId).delete();
      print("Suggestion deleted successfully: $suggestionId");
    } catch (e) {
      print("Failed to delete suggestion: $e");
      throw Exception("Failed to delete suggestion.");
    }
  }

  Future<bool> isUserOwner(String suggestionId) async {
    try {
      DocumentSnapshot snapshot = await _fireStore.collection('suggestions').doc(suggestionId).get();

      if (!snapshot.exists) {
        print("Suggestion not found!");
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

  Future<List<Map<String, dynamic>>> fetchComments(String suggestionId) async {
    try {
      DocumentSnapshot suggestionSnapshot = await FirebaseFirestore.instance
          .collection('suggestions')
          .doc(suggestionId)
          .get();

      if (!suggestionSnapshot.exists) {
        print("Suggestion not found!");
        return [];
      }

      List<dynamic> comments = suggestionSnapshot['comments'] ?? [];
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

  Future<List<Map<String, dynamic>>> fetchSuggestions() async {
    try {
      QuerySnapshot querySnapshot = await _fireStore
          .collection('suggestions')
          .orderBy('timestamp', descending: true)
          .get();

      return querySnapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return {
          'suggestionId': doc.id,
          'suggestion': data['suggestion'],
          'username': data['username'] ?? "Unknown User", // Include username in the suggestion
          'likeCount': data['likeCount'] ?? 0,
          'commentCount': data['commentCount'] ?? 0,
          'timestamp': data['timestamp'],
          'userId': data['userId'],
        };
      }).toList();
    } catch (e) {
      print("Error fetching suggestions: $e");
      throw Exception("Failed to fetch suggestions.");
    }
  }
}