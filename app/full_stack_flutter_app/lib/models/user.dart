class User {
  String name;
  String email;
  int age;
  String city;
  String gender;
  bool employed;

  User({
    required this.name,
    required this.email,
    required this.age,
    required this.city,
    required this.gender,
    required this.employed,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      age: json['age'],
      city: json['city'],
      gender: json['gender'],
      employed: json['employed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'age': age,
      'city': city,
      'gender': gender,
      'employed': employed,
    };
  }
}
