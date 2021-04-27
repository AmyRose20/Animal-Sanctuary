class UserDetails {
  String id;
  String userEmail;
  String userFirstName;
  String userPassword;
  String userPhoneNumber;
  String _userType;

  UserDetails(this.id, this._userType);

  String get userType => _userType;

  UserDetails.fromMap(dynamic object) {
    this.id = object['id'];
    this._userType = object['userType'];
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if(id != null) {
      map['id'] = id;
    }
    map['userType'] = _userType;
    return map;
  }
}