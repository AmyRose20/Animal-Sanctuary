class HomeDetails {
  /* These variables mirror the fields specified in the Firestore
  document.*/
  String id;
  /* When fields begin with an underscore, they can only be accessed in
  the same file where they are defined. */
  String _homeHeader;
  String _homeImage;
  String _homeDescription;

  // Basic constructor
  HomeDetails(this.id, this._homeHeader, this._homeImage, this._homeDescription);

  // Getter methods for private fields
  String get homeHeader => _homeHeader;
  String get homeImage => _homeImage;
  String get homeDescription => _homeDescription;

  /* Constructor titled 'fromMap()', that will take a
  dynamic object and transform it into 'HomeDetails'. */
  HomeDetails.fromMap(dynamic object) {
    this.id = object['id'];
    this._homeHeader = object['homeHeader'];
    this._homeImage = object['homeImage'];
    this._homeDescription = object['homeDescription'];
  }

  /* This method is needed to transform the 'HomeDetails' object into a
  'Map'. A 'Map' in Dart is a collection of 'key-value' pairs. This is why
  we are returning a 'key' of type 'String' and a 'value' of type 'dynamic'
  as it may be any data type. */
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if(id != null) {
      map['id'] = id;
    }
    map['homeHeader'] = _homeHeader;
    map['homeImage'] = _homeImage;
    map['homeDescription'] = _homeDescription;
    return map;
  }
}
