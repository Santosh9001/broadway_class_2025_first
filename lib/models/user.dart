class User {
  String? name;
  String? email;
  String? password;
  String? confirmPassword;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson(User user) {
    Map<String, dynamic> json = {};
    json['name'] = user.name;
    json['email'] = user.email;
    json['password'] = user.password;
    json['confirmPassword'] = user.confirmPassword;
    return json;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        name: json['name'],
        email: json['email'],
        password: json['password'] ?? '',
        confirmPassword: json['confirmPassword'] ?? '');
  }
}
