class PackageModel {
  String title;
  String href;
  String desc;

  PackageModel({required this.title, required this.href, required this.desc});

  factory PackageModel.fromMap(Map<String, dynamic> map) {
    return PackageModel(
      title: map['title'] ?? '',
      href: map['href'] ?? '',
      desc: map['desc'] ?? '',
    );
  }
}
