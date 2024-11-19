class visitorBuildingData {
  bool? success;
  List<String>? buildings;

  visitorBuildingData({this.success, this.buildings});

  visitorBuildingData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    buildings = json['buildings'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['buildings'] = this.buildings;
    return data;
  }
}
