
class Comment{
  String _id;
  String _content;
  String _email;
  String _time;
  String _blogId;

  Comment(this._id, this._content, this._email, this._time, this._blogId);

  String get time => _time;

  set time(String value) {
    _time = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get content => _content;

  set content(String value) {
    _content = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get blogId => _blogId;

  set blogId(String value) {
    _blogId = value;
  }
}