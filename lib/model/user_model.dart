class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  String? userRole;
  String? registrationTime;
  String? postTime;
  String? postLine;
  String? postUsername;
  String? postIsLiked;

  UserModel({this.uid, this.email,
    this.firstName, this.secondName,
    this.userRole, this.registrationTime,
    this.postTime,
    this.postLine,
    this.postUsername,
    this.postIsLiked});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
      userRole: map['userRole'],
      registrationTime: map['registrationTime'],
      postTime: map['postTime'],
      postLine: map['postLine'],
      postUsername: map['postUsername'],
      postIsLiked: map['postIsLiked']
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'userRole':userRole,
      'registrationTime':registrationTime,
      'postTime':postTime,
      'postLine':postLine,
      'postUsername':postUsername,
      'postIsLiked':postIsLiked
    };
  }
}
