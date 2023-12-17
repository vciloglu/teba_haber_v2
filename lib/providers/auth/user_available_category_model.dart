class AvailableCategoryModel {
  // JSON verisindeki text ve value alanlarını tutan iki değişken
  String text = "";
  String value = "";

  // JSON verisinden bir AvailableCategory nesnesi oluşturan kurucu
  AvailableCategoryModel.fromJson(Map<String, dynamic> json) {
    // JSON verisindeki text ve value alanlarını değişkenlere ata
    text = json['text'];
    value = json['value'];
  }
}
