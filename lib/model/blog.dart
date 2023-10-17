class Blog{
  String? _id;
  String _title = "";
  String _content = "";
  String _image = "";
  String _email = "";

  Blog(this._id, this._title, this._content, this._image, this._email);

  String get id => _id ?? "";

  set id(String value) {
    _id = value;
  }

  String get title => _title;

  String get image => _image;

  set image(String value) {
    _image = value;
  }

  String get content => _content;

  set content(String value) {
    _content = value;
  }

  set title(String value) {
    _title = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }
}