class UserModel {
  String? uid;
  String? username;
  String? password;
  String? email;

  UserModel({
    this.uid,
    this.username,
    this.password,
    this.email,
  });

  // recieving data from the server

  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      username: map['username'],
      password: map['password'],
      email: map['email'],
    );
  }

  //sending data to server

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'password': password,
      'email': email,
    };
  }
}
