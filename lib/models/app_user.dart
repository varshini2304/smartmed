class AppUser {
  final String uid;
  final String email;
  final String role;
  final String? name;
  final DateTime? createdAt;

  AppUser({
    required this.uid,
    required this.email,
    required this.role,
    this.name,
    this.createdAt,
  });

  factory AppUser.fromMap(Map<String, dynamic> data, String documentId) {
    return AppUser(
      uid: documentId,
      email: data['email'] ?? '',
      role: data['role'] ?? '',
      name: data['name'],
      createdAt: data['createdAt'] != null
          ? DateTime.parse(data['createdAt'].toString())
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'role': role,
      if (name != null) 'name': name,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}
