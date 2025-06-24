class User {
  final String username;
  final String email;
  final String picture;
  final int score;

  User({
    required this.username,
    required this.email,
    required this.picture,
    required this.score,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      email: json['email'],
      picture: json['picture'],
      score: json['score'],
    );
  }
}