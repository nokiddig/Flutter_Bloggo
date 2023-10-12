class Blog{
  int? _id;
  String _title = "";
  String _content = "";
  String _image = "";

  int get id => _id ?? -1;

  set id(int value) {
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
}