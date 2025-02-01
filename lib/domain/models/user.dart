class User {
  final String login;
  final String password;

  User({required this.login, required this.password})
      : assert(login.isNotEmpty),
        assert(password.isNotEmpty);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      login: json['login'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'password': password,
    };
  }
}
