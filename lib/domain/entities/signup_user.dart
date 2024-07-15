class SignupUser {
  final String name;
  final String email;
  final String password;
  final String avatar;

  SignupUser({
    required this.name,
    required this.email,
    required this.password,
  }) : avatar = "https://gravatar.com/avatar/24afa01781bfcf0d543b4f9224bf";
}
