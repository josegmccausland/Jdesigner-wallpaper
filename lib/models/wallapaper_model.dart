class WallpaperModel {
  final int id;
  final String image;

  WallpaperModel({this.id, this.image});

  factory WallpaperModel.fromMap(Map<String, dynamic> json) =>
      new WallpaperModel(
        id: json["_id"],
        image: json["image"],
      );

  Map<String, dynamic> toMap() => {"_id": id, "image": image};
}
