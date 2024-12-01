class AuthModel {
  String? token;
  String? message;

  AuthModel({
    this.token,
    this.message,
  });

  AuthModel.fromJson(Map<String, dynamic> json) {
    token = json['access_token'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['access_token'] = token;
    data['message'] = message;

    return data;
  }
}
