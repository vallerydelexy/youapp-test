class UserModel {
  final String? image;
  final String? email;
  final String? username;
  final String? name;
  final String? birthday;
  final int? height;
  final int? weight;
  final List<String>? interests;
  final String? gender;

  UserModel({
    this.image,
    this.email,
    this.username,
    this.name,
    this.birthday,
    this.height,
    this.weight,
    this.interests,
    this.gender
  });

  // Factory constructor for parsing JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    // Handle different response structures
    final data = json['data'] ?? json;

    return UserModel(
      email: data['email'],
      username: data['username'],
      name: data['name'],
      birthday: data['birthday'],
      height: data['height'] is int 
        ? data['height'] 
        : int.tryParse(data['height']?.toString() ?? '0'),
      weight: data['weight'] is int 
        ? data['weight'] 
        : int.tryParse(data['weight']?.toString() ?? '0'),
      interests: data['interests'] != null
        ? List<String>.from(data['interests'])
        : [],
      gender: data['gender'],
    );
  }

  // Method to convert to JSON for requests
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'birthday': birthday,
      'height': height,
      'weight': weight,
      'interests': interests,
    };
  }

  // Create a copyWith method for easy updates
  UserModel copyWith({
    String? image,
    String? email,
    String? username,
    String? name,
    String? birthday,
    int? height,
    int? weight,
    List<String>? interests,
    String? gender
  }) {
    return UserModel(
      image: image ?? this.image,
      email: email ?? this.email,
      username: username ?? this.username,
      name: name ?? this.name,
      birthday: birthday ?? this.birthday,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      interests: interests ?? this.interests,
      gender: gender ?? this.gender
    );
  }
}