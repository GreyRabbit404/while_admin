import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:while_admin/views/home/videos/category_details.dart';

class VideosScreen extends StatefulWidget {
  const VideosScreen({super.key});

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Categories'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        // Subscribe to stream of documents in 'videoCategories' collection
        stream: FirebaseFirestore.instance
            .collection('videosCategories')
            .snapshots(),
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          // Display a loading indicator until data arrives
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          // Data is available, display the list of categories
          final documents = snapshot.data!.docs;

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final document = documents[index];
              final category = document
                  .id; // Assuming you want to display the document ID as category name

              return ListTile(
                title: Text(category),
                onTap: () {
                  // Handle category tap, possibly navigate to a detailed screen
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          DetailsView(categoryName: category)));
                },
              );
            },
          );
        },
      ),
    );
  }
}
