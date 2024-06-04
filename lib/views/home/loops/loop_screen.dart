import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:while_admin/models/video_model.dart'; // Make sure this path is correct
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class LoopsView extends StatefulWidget {
  const LoopsView({Key? key}) : super(key: key);

  @override
  _LoopsViewState createState() => _LoopsViewState();
}

class _LoopsViewState extends State<LoopsView> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Loops"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('loops').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final videos = snapshot.data!.docs
              .map((doc) =>
                  VideoModel.fromMap(doc.data() as Map<String, dynamic>))
              .toList();

          return ListView.builder(
            itemCount: videos.length,
            itemBuilder: (context, index) {
              final video = videos[index];
              return ListTile(
                leading: const CircleAvatar(), // Placeholder for thumbnail
                title: Text(video.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(video.description),
                    Text('Uploaded by: ${video.uploadedBy}'),
                  ],
                ),
                isThreeLine: true, // Allows for more space for the subtitle
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Likes: ${video.likes.length}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text('Views: ${video.views}',
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
                onTap: () {
                  // _playVideo(video.videoUrl);
                },
              );
            },
          );
        },
      ),
    );
  }

  void _playVideo(String videoUrl) {
    if (_videoPlayerController != null) {
      _videoPlayerController!
          .dispose(); // Dispose of the old controller if there is one
    }
    _videoPlayerController = VideoPlayerController.network(videoUrl);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      autoPlay: true,
      looping: true,
    );
    setState(() {}); // Rebuild the widget to display the video player
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }
}
