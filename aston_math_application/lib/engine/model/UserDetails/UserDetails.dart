class UserDetails {
  UserDetails({required this.name, required this.age});

  UserDetails.fromJson(Map<String, Object?> json)
      : this(
    name: json['title']! as String,
    age: json['genre']! as String,
  );

  final String name;
  final String age;

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'age': age,
    };
  }
}