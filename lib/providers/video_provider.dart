// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:while_admin/models/video_model.dart'; // Update the path to where your VideoModel is located

// class VideosProvider with ChangeNotifier {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   List<VideoModel> _videos = [];
//   List<String> _videoCategories = []; // Make this mutable for the setter

//   // Getter for video categories
//   List<String> get videoCategories => _videoCategories;

//   // Getter for videos
//   List<VideoModel> get videos => _videos;

//   // Setter for video categories
//   set videoCategories(List<String> categories) {
//     _videoCategories = categories;
//     notifyListeners();
//   }

//   // Setter for videos
//   set videos(List<VideoModel> videosList) {
//     _videos = videosList;
//     notifyListeners();
//   }

//   Future<List<String>> fetchAllCategoryNames() async {
//     try {
//       final QuerySnapshot querySnapshot = await _firestore.collection('videosCategories').get();
//       log(querySnapshot.docs.toString());
//       List<String> categories = querySnapshot.docs.map((doc) => doc.id).toList();
//       videoCategories = categories; // Use setter to update categories and notify listeners
//       return categories;
//     } catch (e) {
//       throw Exception('Error fetching category names: $e');
//     }
//   }

//   Future<void> fetchVideosByCategory(String category) async {
//     try {
//       final QuerySnapshot querySnapshot = await _firestore
//           .collection('videos')
//           .doc(category)
//           .collection(category)
//           .get();

//       List<VideoModel> videosList = querySnapshot.docs
//           .map((doc) => VideoModel.fromMap(doc.data() as Map<String, dynamic>))
//           .toList();
//       videos = videosList; // Use setter to update videos and notify listeners
//     } catch (e) {
//       print("Error fetching videos: $e");
//       // Handle any errors here
//     }
//   }
// }
