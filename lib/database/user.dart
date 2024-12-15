class UserModel {
  final String uid;
  final String email;
  final String password;
  final String role;
  UserModel( {
    required this.uid,
    required this.role,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
