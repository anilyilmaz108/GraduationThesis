class SampleModel{
  final int? id;
  final String? title;
  final String? subtitle;
  final double? price;
  final String? type;
  final String? image;
  final String? gender;



  SampleModel(
      {this.id, this.title, this.subtitle, this.price, this.type, this.image, this.gender});

  factory SampleModel.fromJson(Map<String, dynamic> json) {
    return SampleModel(
      title: json['title'],
      subtitle: json['subtitle'],
      image: json['image'],
      price: json['price'],
      type: json['type'],
      id: json['id'],
      gender: json['gender']
    );
  }
}