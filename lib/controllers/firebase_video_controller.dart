// import 'dart:developer';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:while_admin/models/video_model.dart'; // Ensure this is your model path

// class FirebaseVideoService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//    Future<List<String>> fetchAllCategoryNames() async {
//   try {
//     final QuerySnapshot querySnapshot = await _firestore.collection('videos').get();
//     List<String> categories = querySnapshot.docs
//         .map((doc) => doc.id)
//         .toList();
//     return categories;
//   } catch (e) {
//     throw Exception('Error fetching category names: $e');
//   }
// }



//   Future<List<VideoModel>> fetchVideosByCategory(String category) async {
//     try {
//       final QuerySnapshot querySnapshot = await _firestore
//           .collection('videos')
//           .doc(category)
//           .collection(category)
//           .get();

//       List<VideoModel> videos = querySnapshot.docs
//           .map((doc) => VideoModel.fromMap(doc.data() as Map<String, dynamic>))
//           .toList();
//       log(videos.length.toString());
//       return videos;
//     } catch (e) {
//       throw Exception('Error fetching videos: $e');
//     }
//   }
// }
