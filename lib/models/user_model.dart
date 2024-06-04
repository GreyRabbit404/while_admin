class UserModel {
  final String about;
  final String createdAt;
  final String dateOfBirth;
  final String designation;
  final int easyQuestions;
  final String email;
  final int follower;
  final int following;
  final String gender;
  final int hardQuestions;
  final String id;
  final String image;
  final int isOnline;
  final String lastActive;
  final int lives;
  final int mediumQuestions;
  final String name;
  final String phoneNumber;
  final String place;
  final String profession;
  final String pushToken;
  final int isApproved;
  final int isCounsellerVerified;

  UserModel({
    required this.about,
    required this.createdAt,
    required this.dateOfBirth,
    required this.designation,
    required this.easyQuestions,
    required this.email,
    required this.follower,
    required this.following,
    required this.gender,
    required this.hardQuestions,
    required this.id,
    required this.image,
    required this.isOnline,
    required this.lastActive,
    required this.lives,
    required this.mediumQuestions,
    required this.name,
    required this.phoneNumber,
    required this.place,
    required this.profession,
    required this.pushToken,
    required this.isApproved,
    required this.isCounsellerVerified,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      about: map['about'] ?? '',
      createdAt: map['created_at'] ?? '',
      dateOfBirth: map['dateOfBirth'] ?? '',
      designation: map['designation'] ?? '',
      easyQuestions: map['easyQuestions']?.toInt() ?? 0,
      email: map['email'] ?? '',
      follower: map['follower']?.toInt() ?? 0,
      following: map['following']?.toInt() ?? 0,
      gender: map['gender'] ?? '',
      hardQuestions: map['hardQuestions']?.toInt() ?? 0,
      id: map['id'] ?? '',
      image: map['image'] ?? '',
      isOnline: map['is_online'] ?? 0,
      lastActive: map['last_active'] ?? '',
      lives: map['lives']?.toInt() ?? 0,
      mediumQuestions: map['mediumQuestions']?.toInt() ?? 0,
      name: map['name'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      place: map['place'] ?? '',
      profession: map['profession'] ?? '',
      pushToken: map['push_token'] ?? '',
      isApproved: map['isApproved'] ?? 0,
      isCounsellerVerified: map['isCounsellorVerified'] ?? 0,
    );

  }

  // Method to convert UserModel instance to map, useful for uploading data to Firestore
  Map<String, dynamic> toMap() {
    return {
      'about': about,
      'created_at': createdAt,
      'dateOfBirth': dateOfBirth,
      'designation': designation,
      'easyQuestions': easyQuestions,
      'email': email,
      'follower': follower,
      'following': following,
      'gender': gender,
      'hardQuestions': hardQuestions,
      'id': id,
      'image': image,
      'is_online': isOnline,
      'last_active': lastActive,
      'lives': lives,
      'mediumQuestions': mediumQuestions,
      'name': name,
      'phoneNumber': phoneNumber,
      'place': place,
      'profession': profession,
      'push_token': pushToken,
      'isApproved': isApproved,
      'isCounsellorVerified' : isCounsellerVerified,
    };
  }
}
