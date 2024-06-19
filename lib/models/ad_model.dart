class AdModel {
  final String id;
  final String title;
  final String description;
  final String category;
  final String organisation;
  final String playStoreURL;
  final String thumbnail;
  final String videoUrl;
  final int views;
  final List<dynamic> likes;
  final String website;

  AdModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.organisation,
    required this.playStoreURL,
    required this.thumbnail,
    required this.videoUrl,
    required this.views,
    required this.likes,
    required this.website,
  });

  factory AdModel.fromJson(Map<String, dynamic> json) {
    return AdModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      organisation: json['organisation'] ?? '',
      playStoreURL: json['playStoreURL'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      videoUrl: json['AdModelUrl'] ?? '',
      views: json['views'] ?? 0,
      likes: json['likes'] ?? [],
      website: json['website'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'organisation': organisation,
      'playStoreURL': playStoreURL,
      'thumbnail': thumbnail,
      'videoUrl': videoUrl,
      'views': views,
      'likes': likes,
      'website': website,
    };
  }

  Map<String, dynamic> toMap() {
    return toJson();
  }

  AdModel copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    String? organisation,
    String? playStoreURL,
    String? thumbnail,
    String? videoUrl,
    int? views,
    List<dynamic>? likes,
    String? website,
  }) {
    return AdModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      organisation: organisation ?? this.organisation,
      playStoreURL: playStoreURL ?? this.playStoreURL,
      thumbnail: thumbnail ?? this.thumbnail,
      videoUrl: videoUrl ?? this.videoUrl,
      views: views ?? this.views,
      likes: likes ?? this.likes,
      website: website ?? this.website,
    );
  }

  factory AdModel.empty() {
    return AdModel(
      id: '',
      title: '',
      description: '',
      category: '',
      organisation: '',
      playStoreURL: '',
      thumbnail: '',
      videoUrl: '',
      views: 0,
      likes: [],
      website: '',
    );
  }
}
