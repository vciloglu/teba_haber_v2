class ArticleModel {
  String? id;
  String? title;
  String? subtitle;
  String? image;
  String? date;
  String? body;
  List<String>? categories;

  ArticleModel(
      {this.id,
      this.title,
      this.subtitle,
      this.image = '',
      this.date,
      this.body,
      this.categories});

  // Dışarıda tanımlanan fromJson metodu
  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      image: json['image'],
      date: json['date'],
      body: json['body'],
      categories: (json['categories'] as List<dynamic>)
          .map((x) => x.toString())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['image'] = image;
    data['date'] = date;
    data['body'] = body;
    data["categories"] = categories;
    return data;
  }
}
