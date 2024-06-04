class VideoModel {
  final String description;
  final List<dynamic> likes; // Assuming likes is an array of dynamic objects
  final String thumbnail;
  final String title;
  final String uploadedBy;
  final String videoRef;
  final String videoUrl;
  final int views;

  VideoModel({
    required this.description,
    required this.likes,
    required this.thumbnail,
    required this.title,
    required this.uploadedBy,
    required this.videoRef,
    required this.videoUrl,
    required this.views,
  });

  // Factory method to create an instance of VideoModel from a map
  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      description: map['description'] ?? '',
      likes: map['likes'] ?? [],
      thumbnail: map['thumbnail'] ?? '',
      title: map['title'] ?? '',
      uploadedBy: map['uploadedBy'] ?? '',
      videoRef: map['videoRef'] ?? '',
      videoUrl: map['videoUrl'] ?? '',
      views: map['views']?.toInt() ?? 0,
    );
  }

  // Method to convert VideoModel instance to map, useful for uploading data to Firebase
  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'likes': likes,
      'thumbnail': thumbnail,
      'title': title,
      'uploadedBy': uploadedBy,
      'videoRef': videoRef,
      'videoUrl': videoUrl,
      'views': views,
    };
  }
}
