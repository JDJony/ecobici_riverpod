class Profile {
  const Profile({required this.name, required this.token});

  final String name;
  final String token;

  bool get isEmpty => name.isEmpty && token.isEmpty;
}
