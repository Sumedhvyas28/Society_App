class visitorBuildingData {
  bool? success;
  List<Buildings>? buildings;

  visitorBuildingData({this.success, this.buildings});

  visitorBuildingData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['buildings'] != null) {
      buildings = <Buildings>[];
      json['buildings'].forEach((v) {
        buildings!.add(new Buildings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.buildings != null) {
      data['buildings'] = this.buildings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Buildings {
  int? buildingId;
  String? buildingName;

  Buildings({this.buildingId, this.buildingName});

  Buildings.fromJson(Map<String, dynamic> json) {
    buildingId = json['building_id'];
    buildingName = json['building_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['building_id'] = this.buildingId;
    data['building_name'] = this.buildingName;
    return data;
  }
}
