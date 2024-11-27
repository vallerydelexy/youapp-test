class UserModel {
  String? name;
  String? birthday;
  double? height;
  double? weight;
  List<String>? interest;

  UserModel({
    this.name,
    this.birthday,
    this.height,
    this.weight,
    this.interest,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    birthday = json['birthday'];
    height = json['height'];
    weight = json['weight'];
    interest = json['interest'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['name'] = name;
    data['birthday'] = birthday;
    data['height'] = height;
    data['weight'] = weight;
    data['interest'] = interest;

    return data;
  }
}
