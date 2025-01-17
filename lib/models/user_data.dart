class UserData {
  final int userId;
  final String email;
  final String nickname;
  final int userPoint;
  final int level;

  UserData({
    required this.userId,
    required this.email,
    required this.nickname,
    required this.userPoint,
    required this.level,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      userId: json['userId'] as int, // Ensure this matches the JSON type
      email: json['email'] as String, // Ensure this matches the JSON type
      nickname: json['nickname'] as String,
      userPoint: json['userPoint'] as int,
      level: json['level'] as int,
    );
  }
}
