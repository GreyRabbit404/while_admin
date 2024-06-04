import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:while_admin/models/video_model.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class DetailsView extends StatefulWidget {
  final String categoryName;

  const DetailsView({Key? key, required this.categoryName}) : super(key: key);

  @override
  _DetailsViewState createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('videos')
            .doc(widget.categoryName)
            .collection(widget.categoryName)
            .snapshots(),
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
            itemCount: videos.length + 1, // +1 for the video player at the top
            itemBuilder: (context, index) {
              if (index == 0) {
                // The video player
                return _chewieController != null &&
                        _chewieController!
                            .videoPlayerController.value.isInitialized
                    ? SizedBox(
                        height: 250, // Adjust size as needed
                        child: Chewie(controller: _chewieController!),
                      )
                    : Container();
              }
              final video = videos[index - 1]; // Adjust index for videos
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
                isThreeLine: true,
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Likes: ${video.likes.length}',
                        style: const TextStyle(fontSize: 16)),
                    Text('Views: ${video.views}',
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
                onTap: () {
                  // _playVideo(video.videoUrl);
                  // Optionally, show video details below the player or in another widget
                },
              );
            },
          );
        },
      ),
    );
  }

  void _playVideo(String videoUrl) {
    _videoPlayerController = VideoPlayerController.network(videoUrl);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      autoPlay: true,
      looping: false,
    );
    setState(() {
      // Update the UI when the video player is ready
    });
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }
}
