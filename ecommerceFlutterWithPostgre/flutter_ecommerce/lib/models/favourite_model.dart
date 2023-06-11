class FavouriteModel{
  final int? id;
  final String? userid;
  final int? favid;



  FavouriteModel(
      {this.id, this.userid, this.favid});

  factory FavouriteModel.fromJson(Map<String, dynamic> json) {
    return FavouriteModel(
      favid: json['fav_id'],
      userid: json['user_id'],
      id: json['id'],
    );
  }
}