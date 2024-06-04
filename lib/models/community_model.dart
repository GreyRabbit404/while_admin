class CommunityModel {
  final String about;
  final String admin;
  final String createdAt;
  final String domain;
  final int easyQuestions;
  final String email;
  final int hardQuestions;
  final String id;
  final String image;
  final int mediumQuestions;
  final String name;
  final String noOfUsers;
  final String timeStamp;
  final String type;

  CommunityModel({
    required this.about,
    required this.admin,
    required this.createdAt,
    required this.domain,
    required this.easyQuestions,
    required this.email,
    required this.hardQuestions,
    required this.id,
    required this.image,
    required this.mediumQuestions,
    required this.name,
    required this.noOfUsers,
    required this.timeStamp,
    required this.type,
  });

  factory CommunityModel.fromMap(Map<String, dynamic> map) {
    return CommunityModel(
      about: map['about'] ?? '',
      admin: map['admin'] ?? '',
      createdAt: map['created_at'] ?? '',
      domain: map['domain'] ?? '',
      easyQuestions: map['easyQuestions']?.toInt() ?? 0,
      email: map['email'] ?? '',
      hardQuestions: map['hardQuestions']?.toInt() ?? 0,
      id: map['id'] ?? '',
      image: map['image'] ?? '',
      mediumQuestions: map['mediumQuestions']?.toInt() ?? 0,
      name: map['name'] ?? '',
      noOfUsers: map['noOfUsers'] ?? '',
      timeStamp: map['timeStamp'] ?? '',
      type: map['type'] ?? '',
    );
  }

  // Method to convert CommunityModel instance to map, useful for uploading data to Firestore
  Map<String, dynamic> toMap() {
    return {
      'about': about,
      'admin': admin,
      'created_at': createdAt,
      'domain': domain,
      'easyQuestions': easyQuestions,
      'email': email,
      'hardQuestions': hardQuestions,
      'id': id,
      'image': image,
      'mediumQuestions': mediumQuestions,
      'name': name,
      'noOfUsers': noOfUsers,
      'timeStamp': timeStamp,
      'type': type,
    };
  }
}
