class Category{
  String _name = "";
  String _description = "";
  String _image = "";

  Category(this._name, this._description, this._image);

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}