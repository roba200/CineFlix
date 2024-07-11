class User {
  int id;
  String fname;
  String lname;
  String email;
  String password;
  User(
      {required int this.id,
      required String this.fname,
      required String this.lname,
      required String this.email,
      required String this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fname: json['fname'],
      lname: json['lname'],
      email: json['email'],
      password: json['password'],
    );
  }
}
