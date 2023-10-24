class Follow{
  String? id;
  String _followerEmail;
  String _followingEmail;

  Follow(this.id, this._followerEmail, this._followingEmail);

  String get followingEmail => _followingEmail;

  set followingEmail(String value) {
    _followingEmail = value;
  }

  String get followerEmail => _followerEmail;

  set followerEmail(String value) {
    _followerEmail = value;
  }
}