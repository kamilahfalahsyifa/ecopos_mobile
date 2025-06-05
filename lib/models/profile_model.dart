class UserProfile {
  final String name;
  final String email;
  final String role;
  final String outletId;
  final String password;

  UserProfile({
    required this.name,
    required this.email,
    required this.role,
    required this.outletId,
    required this.password,
  });

  UserProfile copyWith({
    String? name,
    String? email,
    String? role,
    String? outletId,
    String? password,
  }) {
    return UserProfile(
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      outletId: outletId ?? this.outletId,
      password: password ?? this.password,
    );
  }
}
