class HomeScreenResponse {
  String id;
  String title;
  List<SubPaths> subPaths;

  HomeScreenResponse({this.id, this.title, this.subPaths});

  HomeScreenResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    if (json['sub_paths'] != null) {
      subPaths = new List<SubPaths>();
      json['sub_paths'].forEach((v) {
        subPaths.add(new SubPaths.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    if (this.subPaths != null) {
      data['sub_paths'] = this.subPaths.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubPaths {
  String id;
  String title;
  String image;
  bool isSelected = false;

  SubPaths({this.id, this.title, this.image});

  SubPaths.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    return data;
  }
}
