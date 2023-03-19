class UserData {
  UserData({
    required this.image,
    required this.firstname,
    required this.lastname,
    required this.tel,
    required this.email,
  });

  final String image;
  final String firstname;
  final String lastname;
  final String tel;
  final String email;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        image: json["image"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        tel: json["tel"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "firstname": firstname,
        "lastname": lastname,
        "tel": tel,
        "email": email,
      };
}
