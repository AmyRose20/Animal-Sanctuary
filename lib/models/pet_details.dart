class PetDetails {
  /* These variables mirror the fields specified in the collection's
  'PetDetails' document. */
  /* Note: When variables/fields begin with an underscore, they can only be
  accessed in the same file where they are defined. */
  String id;
  String _petName;
  String _petImage;
  String _petDescription;
  int _petAge;
  String _petType;

  // Basic constructor
  PetDetails(this.id, this._petName, this._petImage, this._petDescription,
      this._petAge, this._petType);

  // Getter methods for private variables/fields
  String get petName => _petName;
  String get petImage => _petImage;
  String get petDescription => _petDescription;
  int get petAge => _petAge;
  String get petType => _petType;

  /* Constructor named 'fromMap()', that will take a
  dynamic object and transform it into 'PetDetails'. */
  PetDetails.fromMap(dynamic object) {
    this.id = object['id'];
    this._petName = object['petName'];
    this._petImage = object['petImage'];
    this._petDescription = object['petDescription'];
    this._petAge = object['petAge'];
    this._petType = object['petType'];
  }

  /* This method is needed to transform the 'PetDetails' object into a
  'Map'. A 'Map' in Dart is a collection of 'key-value' pairs. This is why
  we are returning a 'key' of type 'String' and a 'value' of type 'dynamic'
  as it may be any data type. */
  Map<String, dynamic> toMap() {
    // assign 'Map' instance of type String, dynamic to variable 'map'
    var map = Map<String, dynamic>();
    /* retrieve document's IDs before the rest of its variables so next part
    of code is not redundant */
    if(id != null) {
      map['id'] = id;
    }
    map['petName'] = _petName;
    map['petImage'] = _petImage;
    map['petDescription'] = _petDescription;
    map['petAge'] = _petAge;
    map['petType'] = _petType;

    return map;
  }
}